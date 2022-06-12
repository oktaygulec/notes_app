import 'package:flutter/material.dart';

import '/enums.dart';
import '/styles.dart';
import '/models/category.dart';
import '/widgets/components/appbars/on_edit_app_bar.dart';
import '/screens/notes/category_dialog.dart';

class PushedCategoryAppBar extends StatefulWidget with PreferredSizeWidget {
  final Category category;
  final Function(String)? onSearch;

  PushedCategoryAppBar({
    Key? key,
    required this.category,
    this.onSearch,
  }) : super(key: key);

  @override
  Size get preferredSize => const Size(double.infinity, kToolbarHeight);

  @override
  State<PushedCategoryAppBar> createState() => _PushedCategoryAppBarState();
}

class _PushedCategoryAppBarState extends State<PushedCategoryAppBar> {
  bool _isSearching = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AppBar(
          automaticallyImplyLeading: false,
          leading: _isSearching
              ? null
              : IconButton(
                  splashRadius: 16,
                  icon: const Icon(Icons.arrow_back_ios_new_sharp),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
          title: !_isSearching
              ? null
              : TextField(
                  onChanged: widget.onSearch,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: backgroundColor,
                    focusColor: backgroundColor,
                    hintText: "Search note",
                    hintStyle: TextType.searchPlaceholder.style,
                    prefixIcon: const Icon(
                      Icons.search,
                      color: textColor,
                    ),
                    border: const UnderlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(4),
                      ),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: const UnderlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(4),
                      ),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
          actions: _isSearching
              ? [
                  IconButton(
                    splashRadius: 16,
                    icon: const Icon(Icons.close),
                    onPressed: () => setState(() {
                      _isSearching = false;
                      widget.onSearch!.call("");
                    }),
                  ),
                ]
              : [
                  IconButton(
                    splashRadius: 16,
                    icon: const Icon(Icons.search),
                    onPressed: () => setState(() {
                      _isSearching = true;
                    }),
                  ),
                  IconButton(
                    splashRadius: 16,
                    icon: const Icon(Icons.edit),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (ctx) => CategoryDialog(
                          actionType: ActionType.edit,
                          category: widget.category,
                        ),
                      );
                    },
                  ),
                ],
        ),
        const OnEditAppBar(
          hasTab: false,
        ),
      ],
    );
  }
}
