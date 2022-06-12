import 'package:flutter/material.dart';

import '/enums.dart';
import '/models/category.dart';
import '/models/note.dart';
import '/widgets/components/appbars/pushed_category_app_bar.dart';
import '/widgets/components/empty_placeholder.dart';
import '/widgets/components/list_with_title.dart';
import '/screens/notes/new_note_screen.dart';

class CategoryDetailsScreen extends StatefulWidget {
  const CategoryDetailsScreen({Key? key}) : super(key: key);

  static const routeName = "/category-details";

  @override
  State<CategoryDetailsScreen> createState() => _CategoryDetailsScreenState();
}

class _CategoryDetailsScreenState extends State<CategoryDetailsScreen> {
  String _searchText = "";
  List<Note?> _filteredItems = [];

  @override
  Widget build(BuildContext context) {
    Category category = ModalRoute.of(context)!.settings.arguments as Category;
    // Get category id and fetch data with consumer(?)

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PushedCategoryAppBar(
        category: category,
        onSearch: (v) {
          setState(() {
            _searchText = v;

            _filteredItems = category.notes!.values.map((e) {
              if (e.title.contains(_searchText)) {
                return e;
              }
            }).toList();

            _filteredItems.removeWhere((note) => note == null);
          });
        },
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: category.notes == null
            ? MainAxisAlignment.center
            : MainAxisAlignment.start,
        children: [
          category.notes != null
              ? ListWithTitle(
                  titleType: TitleType.title,
                  title: category.title,
                  listType: ListType.note,
                  items: _searchText.isEmpty
                      ? category.notes!.values.toList()
                      : _filteredItems,
                )
              : EmptyPlaceholder(
                  text: "You don't have any notes...\nLet's add some!",
                  icon: Icons.description_outlined,
                  buttonText: "Add Note",
                  buttonOnPress: () {
                    Navigator.of(context).pushNamed(NewNoteScreen.routeName);
                  },
                )
        ],
      ),
    );
  }
}
