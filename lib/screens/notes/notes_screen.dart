import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

import '/enums.dart';
import '/styles.dart';
import '/widgets/components/appbars/logo_app_bar.dart';
import '/widgets/contents/notes/notes_content.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: LogoAppBar(
        hasTab: true,
        tabController: _tabController,
      ),
      body: NotesContent(tabController: _tabController),
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
              // backgroundColor: textColor,
              // labelBackgroundColor: textColor,
              // labelStyle: TextType.text.style!.copyWith(color: primaryColor),
              // foregroundColor: primaryColor,
              backgroundColor: Colors.white,
              labelBackgroundColor: Colors.white,
              labelStyle: TextType.text.style!,
              foregroundColor: textColor,
              onTap: () {
                // TODO: Navigate to Add Note screen(?)
              }),
          SpeedDialChild(
              child: const Icon(Icons.folder),
              label: "Category",
              // backgroundColor: textColor,
              // labelBackgroundColor: textColor,
              // labelStyle: TextType.text.style!.copyWith(color: primaryColor),
              // foregroundColor: primaryColor,
              backgroundColor: Colors.white,
              labelBackgroundColor: Colors.white,
              labelStyle: TextType.text.style!,
              foregroundColor: textColor,
              onTap: () {
                // TODO: Navigate to Add Category screen(?)
              }),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
