import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/enums.dart';
import '/providers/appbar_status.dart';
import '/styles.dart';

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
                icon: const Icon(Icons.arrow_back_ios_new_sharp),
                onPressed: () {
                  prov.changeMode(AppBarMode.normal);
                },
              ),
              actions: [
                IconButton(
                  splashRadius: 16,
                  icon: const Icon(Icons.push_pin),
                  onPressed: () {},
                ),
                IconButton(
                  splashRadius: 16,
                  icon: const Icon(Icons.delete),
                  onPressed: () {},
                ),
                IconButton(
                  splashRadius: 16,
                  icon: const Icon(Icons.edit),
                  onPressed: () {},
                ),
              ],
            ),
          )
        : const SizedBox();
  }
}
