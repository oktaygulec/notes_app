import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '/enums.dart';
import '/styles.dart';
import '/widgets/components/custom_text.dart';
import '/widgets/components/appbars/on_edit_app_bar.dart';

class LogoAppBar extends StatefulWidget with PreferredSizeWidget {
  final bool hasTab;
  final TabController? tabController;
  final Function(String)? onSearch;

  const LogoAppBar({
    this.hasTab = false,
    this.tabController,
    this.onSearch,
    Key? key,
  }) : super(key: key);

  @override
  Size get preferredSize => Size(double.infinity,
      hasTab ? kToolbarHeight + kTextTabBarHeight : kToolbarHeight);

  @override
  State<LogoAppBar> createState() => _LogoAppBarState();
}

class _LogoAppBarState extends State<LogoAppBar> {
  bool _isSearching = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AppBar(
          bottom: widget.hasTab
              ? TabBar(
                  controller: widget.tabController,
                  tabs: const [
                    Tab(
                      text: "NOTES",
                    ),
                    Tab(
                      text: "CATEGORIES",
                    ),
                  ],
                )
              : null,
          title: _isSearching
              ? TextField(
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
                )
              : Row(
                  children: [
                    SvgPicture.asset(
                      "assets/images/Logo.svg",
                      width: 24,
                    ),
                    SizedBox(
                      width: iconTextPadding.horizontal,
                    ),
                    const CustomText(
                      "NOTES",
                      textType: TextType.appBarLogoTitle,
                    ),
                  ],
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
                    onPressed: () => setState(() => _isSearching = true),
                  ),
                  IconButton(
                    splashRadius: 16,
                    icon: const Icon(Icons.more_vert),
                    onPressed: () {},
                  ),
                ],
        ),
        OnEditAppBar(
          hasTab: widget.hasTab,
          tabController: widget.tabController,
        ),
      ],
    );
  }
}
