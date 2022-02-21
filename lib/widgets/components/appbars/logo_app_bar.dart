import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '/enums.dart';
import '/styles.dart';
import '/widgets/components/custom_text.dart';
import '/widgets/components/appbars/on_edit_app_bar.dart';

class LogoAppBar extends StatelessWidget with PreferredSizeWidget {
  final bool hasTab;
  final TabController? tabController;
  const LogoAppBar({this.hasTab = false, this.tabController, Key? key})
      : super(key: key);

  @override
  Size get preferredSize => Size(double.infinity,
      hasTab ? kToolbarHeight + kTextTabBarHeight : kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AppBar(
          bottom: hasTab
              ? TabBar(
                  controller: tabController,
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
          title: Row(
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
                textType: TextType.appBarTitle,
              ),
            ],
          ),
          actions: [
            IconButton(
              splashRadius: 16,
              icon: const Icon(Icons.search),
              onPressed: () {},
            ),
            IconButton(
              splashRadius: 16,
              icon: const Icon(Icons.more_vert),
              onPressed: () {},
            ),
          ],
        ),
        OnEditAppBar(
          hasTab: hasTab,
          tabController: tabController,
        ),
      ],
    );
  }
}
