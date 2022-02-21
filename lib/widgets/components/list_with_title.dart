import 'package:flutter/material.dart';

import '/enums.dart';
import '/widgets/components/card/card_list.dart';
import '/widgets/components/custom_text.dart';
import '/widgets/components/title_bar.dart';

class ListWithTitle extends StatelessWidget {
  final TitleType titleType;
  final ListType listType;
  final List<dynamic> items;
  final String? title;

  const ListWithTitle({
    Key? key,
    required this.titleType,
    required this.listType,
    required this.items,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Icon? _icon;
    String _titleBarText;
    CardType _cardType = CardType.large;

    switch (titleType) {
      case TitleType.all:
        _icon = const Icon(Icons.list_rounded);
        if (listType == ListType.category) {
          _titleBarText = "ALL CATEGORIES";
          _cardType = CardType.long;
        } else {
          _titleBarText = "ALL NOTES";
          _cardType = CardType.large;
        }
        break;
      case TitleType.pinned:
        _icon = const Icon(Icons.push_pin);
        _titleBarText = "PINNED";
        _cardType =
            listType == ListType.note ? CardType.medium : CardType.small;
        break;
      case TitleType.recent:
        _icon = const Icon(Icons.history);
        _titleBarText = "RECENT";
        _cardType = CardType.large;
        break;
      case TitleType.title:
        _titleBarText = title!;
        _cardType = CardType.large;
        break;
      default:
        _titleBarText = "???";
        break;
    }
    return Column(
      children: [
        _icon != null
            ? TitleBar(
                icon: _icon,
                title: _titleBarText,
                amount: items.length,
              )
            : CustomText(
                title!,
                textType: TextType.title,
              ),
        CardList(
          items: items,
          cardType: _cardType,
        ),
      ],
    );
  }
}
