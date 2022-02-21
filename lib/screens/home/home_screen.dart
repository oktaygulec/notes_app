import 'package:flutter/material.dart';

import '/styles.dart';
import '/widgets/components/appbars/logo_app_bar.dart';
import '/widgets/contents/home/notes_content.dart';
import '/widgets/contents/home/home_content.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static const routeName = "/home";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  int _currentIndex = 0;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: _currentIndex == 0
          ? const LogoAppBar()
          : LogoAppBar(
              hasTab: true,
              tabController: _tabController,
            ),
      body: _currentIndex == 0
          ? const HomeContent()
          : _currentIndex == 1
              ? NotesContent(tabController: _tabController)
              : Container(),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: primaryColor,
        selectedItemColor: textColor,
        unselectedItemColor: textColorOpacity60,
        unselectedFontSize: 14.0,
        currentIndex: _currentIndex,
        onTap: (index) => setState(() {
          _currentIndex = index;
        }),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: "Home",
            activeIcon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.description_outlined),
            label: "Notes",
            activeIcon: Icon(Icons.description),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_outlined),
            label: "Settings",
            activeIcon: Icon(Icons.settings),
          ),
        ],
      ),
      floatingActionButton: _currentIndex != 2
          ? FloatingActionButton(
              child: const Icon(
                Icons.add,
              ),
              onPressed: () {},
            )
          : const SizedBox(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
