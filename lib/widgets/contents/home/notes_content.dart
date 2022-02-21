import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/enums.dart';
import '/models/category.dart';
import '/models/note.dart';
import '/providers/categories.dart';
import '/widgets/components/list_with_title.dart';

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
        return Consumer<Categories>(
          // builder: (context, data, child) => data.items.isEmpty
          builder: (context, data, child) => data.items.isNotEmpty
              ? const Center(child: Text("Add category"))
              : TabBarView(
                  controller: tabController,
                  children: [
                    SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ListWithTitle(
                            listType: ListType.note,
                            titleType: TitleType.pinned,
                            items: [
                              Note(
                                  title: "Music",
                                  description:
                                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor."),
                              Note(
                                  title: "Work",
                                  description:
                                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor."),
                              Note(
                                  title: "School",
                                  description: "Lorem ipsum dolor sit amet"),
                              Note(
                                  title: "Check Server",
                                  description: "Lorem ipsum dolor sit amet"),
                              Note(
                                  title: "Shopping List",
                                  description: "Lorem ipsum dolor sit amet"),
                            ],
                          ),
                          ListWithTitle(
                            listType: ListType.note,
                            titleType: TitleType.all,
                            items: [
                              Note(
                                  title: "Music",
                                  description:
                                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor."),
                              Note(
                                  title: "Work",
                                  description:
                                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor."),
                              Note(
                                  title: "School",
                                  description: "Lorem ipsum dolor sit amet"),
                              Note(
                                  title: "Check Server",
                                  description: "Lorem ipsum dolor sit amet"),
                              Note(
                                  title: "Shopping List",
                                  description: "Lorem ipsum dolor sit amet"),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ListWithTitle(
                            listType: ListType.category,
                            titleType: TitleType.pinned,
                            items: [
                              Category(
                                title: "Music",
                                notes: {
                                  "Note1": Note(
                                    title: "Music",
                                    description:
                                        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor.",
                                  ),
                                  "Note2": Note(
                                    title: "Music",
                                    description:
                                        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor.",
                                  ),
                                  "Note3": Note(
                                    title: "Music",
                                    description:
                                        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor.",
                                  ),
                                },
                              ),
                              Category(
                                title: "Work",
                                notes: {
                                  "Note1": Note(
                                    title: "Music",
                                    description:
                                        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor.",
                                  ),
                                  "Note2": Note(
                                    title: "Music",
                                    description:
                                        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor.",
                                  ),
                                  "Note3": Note(
                                    title: "Music",
                                    description:
                                        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor.",
                                  ),
                                },
                              ),
                              Category(
                                title: "School",
                                notes: {
                                  "Note1": Note(
                                    title: "Music",
                                    description:
                                        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor.",
                                  ),
                                  "Note2": Note(
                                    title: "Music",
                                    description:
                                        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor.",
                                  ),
                                  "Note3": Note(
                                    title: "Music",
                                    description:
                                        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor.",
                                  ),
                                },
                              ),
                            ],
                          ),
                          ListWithTitle(
                            listType: ListType.category,
                            titleType: TitleType.all,
                            items: [
                              Category(
                                title: "Music",
                                notes: {
                                  "Note1": Note(
                                    title: "Music",
                                    description:
                                        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor.",
                                  ),
                                  "Note2": Note(
                                    title: "Music",
                                    description:
                                        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor.",
                                  ),
                                  "Note3": Note(
                                    title: "Music",
                                    description:
                                        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor.",
                                  ),
                                },
                              ),
                              Category(
                                title: "Work",
                                notes: {
                                  "Note1": Note(
                                    title: "Music",
                                    description:
                                        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor.",
                                  ),
                                  "Note2": Note(
                                    title: "Music",
                                    description:
                                        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor.",
                                  ),
                                  "Note3": Note(
                                    title: "Music",
                                    description:
                                        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor.",
                                  ),
                                },
                              ),
                              Category(
                                title: "School",
                                notes: {
                                  "Note1": Note(
                                    title: "Music",
                                    description:
                                        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor.",
                                  ),
                                  "Note2": Note(
                                    title: "Music",
                                    description:
                                        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor.",
                                  ),
                                  "Note3": Note(
                                    title: "Music",
                                    description:
                                        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor.",
                                  ),
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
        );
      },
    );
  }
}
