import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:provider/provider.dart';

import '/enums.dart';
import '/styles.dart';
import '/models/category.dart';
import '/models/note.dart';
import '/providers/categories.dart';
import '/widgets/components/appbars/logo_app_bar.dart';
import '/widgets/components/empty_placeholder.dart';
import '/widgets/components/list_with_title.dart';
import '/widgets/components/scrollable_lists_view.dart';
import '/screens/notes/category_dialog.dart';
import '/screens/notes/new_note_screen.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({Key? key}) : super(key: key);
  static const routeName = "/home";

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  String _searchText = "";
  List<Note?> _filteredNotes = [];
  List<Category?> _filteredCategories = [];

  @override
  Widget build(BuildContext context) {
    // Categories _categories = Provider.of<Categories>(context);

    return Consumer<Categories>(builder: (_, _categories, __) {
      _categories.init();
      return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: LogoAppBar(
          hasTab: true,
          tabController: _tabController,
          onSearch: (v) => setState(() {
            _searchText = v;

            _filteredNotes = _categories.getAllNotes().map((e) {
              e.title.toLowerCase();
              _searchText.toLowerCase();
              if (e.title.contains(_searchText)) {
                return e;
              }
            }).toList();

            _filteredCategories = _categories.items.values.map((e) {
              e.title.toLowerCase();
              _searchText.toLowerCase();
              if (e.title.contains(_searchText)) {
                return e;
              }
            }).toList();

            _filteredNotes.removeWhere((note) => note == null);
            _filteredCategories.removeWhere((category) => category == null);
          }),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            _categories.getAllNotes().isEmpty
                ? EmptyPlaceholder(
                    text: "You don't have any notes...\nLet's add some!",
                    icon: Icons.description_outlined,
                    buttonText: "Add Note",
                    buttonOnPress: () {
                      Navigator.of(context).pushNamed(NewNoteScreen.routeName);
                    },
                  )
                : ScrollableListsView(
                    lists: [
                      if (_categories.getPinnedNotes().isNotEmpty &&
                          _searchText.isEmpty)
                        ListWithTitle(
                          titleType: TitleType.pinned,
                          listType: ListType.note,
                          items: _categories.getPinnedNotes(),
                        ),
                      ListWithTitle(
                        titleType: TitleType.all,
                        listType: ListType.note,
                        items: _searchText.isNotEmpty
                            ? _filteredNotes
                            : _categories.getAllNotes(),
                      ),
                    ],
                  ),
            _categories.items.isEmpty
                ? EmptyPlaceholder(
                    text: "You don't have any categories...\nLet's add some!",
                    icon: Icons.folder_outlined,
                    buttonText: "Add Category",
                    buttonOnPress: () {
                      showDialog(
                        context: context,
                        builder: (_) => const CategoryDialog(
                          actionType: ActionType.create,
                        ),
                      );
                    },
                  )
                : ScrollableListsView(
                    lists: [
                      if (_categories.pinnedCategories.isNotEmpty &&
                          _searchText.isEmpty)
                        ListWithTitle(
                          titleType: TitleType.pinned,
                          listType: ListType.category,
                          items: _categories.pinnedCategories,
                        ),
                      ListWithTitle(
                        titleType: TitleType.all,
                        listType: ListType.category,
                        items: _searchText.isNotEmpty
                            ? _filteredCategories
                            : _categories.items.values.toList(),
                      ),
                    ],
                  ),
          ],
        ),
        floatingActionButton: SpeedDial(
          icon: Icons.add,
          activeIcon: Icons.close,
          overlayOpacity: 0.35,
          overlayColor: Colors.black,
          spacing: 16,
          childMargin: const EdgeInsets.all(8.0),
          childrenButtonSize: const Size(64, 64),
          children: [
            SpeedDialChild(
                child: const Icon(Icons.description),
                label: "Note",
                backgroundColor: Colors.white,
                labelBackgroundColor: Colors.white,
                labelStyle: TextType.text.style!,
                foregroundColor: textColor,
                onTap: () {
                  Navigator.of(context).pushNamed(NewNoteScreen.routeName);
                }),
            SpeedDialChild(
                child: const Icon(Icons.folder),
                label: "Category",
                backgroundColor: Colors.white,
                labelBackgroundColor: Colors.white,
                labelStyle: TextType.text.style!,
                foregroundColor: textColor,
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (_) =>
                        const CategoryDialog(actionType: ActionType.create),
                  );
                }),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      );
    });
  }
}
