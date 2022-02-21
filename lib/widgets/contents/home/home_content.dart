import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/enums.dart';
import '/models/note.dart';
import '/providers/categories.dart';
import '/widgets/components/list_with_title.dart';

class HomeContent extends StatelessWidget {
  const HomeContent({Key? key}) : super(key: key);

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
              : SingleChildScrollView(
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
                        titleType: TitleType.recent,
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
        );
      },
    );
  }
}
