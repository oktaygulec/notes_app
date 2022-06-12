import 'package:flutter/material.dart';
import 'package:notesapp/screens/notes/category_dialog.dart';
import 'package:provider/provider.dart';

import '/enums.dart';
import '/styles.dart';
import '/models/note.dart';
import '/providers/categories.dart';
import '/providers/appbar_status.dart';
import '/widgets/components/custom_text.dart';
import '/screens/notes/note_details_screen.dart';

class OnEditAppBar extends StatefulWidget {
  final bool hasTab;
  final TabController? tabController;
  const OnEditAppBar({
    Key? key,
    required this.hasTab,
    this.tabController,
  }) : super(key: key);

  @override
  State<OnEditAppBar> createState() => _OnEditAppBarState();
}

class _OnEditAppBarState extends State<OnEditAppBar>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;
  late Animation<Color?> _colorAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _colorAnimation =
        ColorTween(begin: primaryColor, end: primaryVariantColor).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _opacityAnimation.addListener(() => setState(() {}));
    _colorAnimation.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<AppBarStatus>(context);
    final cat = Provider.of<Categories>(context, listen: false);

    if (prov.mode == AppBarMode.normal) {
      _controller.reverse();
    } else {
      _controller.forward();
    }
    return _opacityAnimation.value > 0
        ? Opacity(
            opacity: _opacityAnimation.value,
            child: AppBar(
              backgroundColor: _colorAnimation.value,
              elevation: 0,
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
              leading: IconButton(
                splashRadius: 16,
                icon: const Icon(Icons.close),
                onPressed: () {
                  prov.changeMode(AppBarMode.normal);
                },
              ),
              actions: [
                IconButton(
                  splashRadius: 16,
                  icon: prov.item.isPinned
                      ? const Icon(Icons.push_pin)
                      : const Icon(Icons.push_pin_outlined),
                  onPressed: () async {
                    prov.item.runtimeType == Note
                        ? await cat.pinNoteSwitch(prov.item)
                        : await cat.pinCategorySwitch(prov.item);
                    prov.changeMode(AppBarMode.normal);
                    final pinnedText = prov.item.isPinned
                        ? "${prov.item.title} is pinned!"
                        : "${prov.item.title} is unpinned!";
                    _showSnackbar(context, pinnedText);
                  },
                ),
                IconButton(
                  splashRadius: 16,
                  icon: const Icon(Icons.delete),
                  onPressed: () async {
                    prov.item.runtimeType == Note
                        ? await cat.deleteNote(prov.item)
                        : await cat.deleteCategory(prov.item);
                    prov.changeMode(AppBarMode.normal);
                    _showSnackbar(context, "${prov.item.title} is removed!");
                  },
                ),
                IconButton(
                  splashRadius: 16,
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    if (prov.item.runtimeType == Note) {
                      Navigator.of(context).pushNamed(
                        NoteDetailsScreen.routeName,
                        arguments: prov.item,
                      );
                    } else {
                      showDialog(
                        context: context,
                        builder: (ctx) => const CategoryDialog(
                          actionType: ActionType.edit,
                        ),
                      );
                    }
                    prov.changeMode(AppBarMode.normal);
                  },
                ),
              ],
            ),
          )
        : const SizedBox();
  }
}

_showSnackbar(context, text) {
  ScaffoldMessenger.of(context).hideCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: CustomText(
        text,
        textType: TextType.secondaryButton,
        alignment: TextAlign.center,
      ),
      backgroundColor: primaryColor,
    ),
  );
}
