import 'package:flutter/material.dart';
import '/widgets/components/list_with_title.dart';

class ScrollableListsView extends StatelessWidget {
  final List<ListWithTitle> lists;
  const ScrollableListsView({
    Key? key,
    required this.lists,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: lists,
      ),
    );
  }
}
