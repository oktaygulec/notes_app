import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/enums.dart';
import '/models/category.dart';
import '/models/note.dart';
import '/providers/categories.dart';
import '/providers/notes.dart';
import '/widgets/components/empty_placeholder.dart';
import '/widgets/components/list_with_title.dart';
import '/widgets/components/scrollable_lists_view.dart';

class NotesContent extends StatelessWidget {
  final TabController tabController;
  const NotesContent({Key? key, required this.tabController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Provider.of<Categories>(context, listen: false).getCategories(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        return Consumer2<Categories, Notes>(
          // builder: (context, data, child) => data.items.isEmpty
          builder: (context, cat, notes, child) => cat.items.isNotEmpty
              ? const Center(child: Text("Add category"))
              : TabBarView(
                  controller: tabController,
                  children: [
                    notes.getAllNotes(context).isEmpty
                        ? EmptyPlaceholder(
                            text:
                                "You don't have any notes... \n Let's add some!",
                            icon: Icons.description_outlined,
                            buttonText: "Add Note",
                            buttonOnPress: () {
                              // TODO: Navigate to Add Note screen(?)
                            },
                          )
                        : ScrollableListsView(
                            lists: [
                              if (notes.getPinnedNotes(context).isNotEmpty)
                                ListWithTitle(
                                  titleType: TitleType.pinned,
                                  listType: ListType.note,
                                  items: notes.getPinnedNotes(context),
                                ),
                              ListWithTitle(
                                titleType: TitleType.all,
                                listType: ListType.note,
                                items: notes.getAllNotes(context),
                              ),
                            ],
                          ),
                    cat.items.isEmpty
                        ? EmptyPlaceholder(
                            text:
                                "You don't have any categories... \n Let's add some!",
                            icon: Icons.folder_outlined,
                            buttonText: "Add Category",
                            buttonOnPress: () {
                              // TODO: Navigate to Add Category screen(?)
                            },
                          )
                        : ScrollableListsView(
                            lists: [
                              if (cat.pinnedItems.isNotEmpty)
                                ListWithTitle(
                                  titleType: TitleType.pinned,
                                  listType: ListType.category,
                                  items: cat.pinnedItems,
                                ),
                              ListWithTitle(
                                titleType: TitleType.all,
                                listType: ListType.category,
                                items: cat.items.values.toList(),
                              ),
                            ],
                          ),
                  ],
                ),
        );
      },
    );
  }
}
