import 'package:flutter/material.dart';

import '/enums.dart';
import '/widgets/components/card/custom_card.dart';

class CardList extends StatelessWidget {
  final List<dynamic> items;
  final CardType cardType;

  const CardList({
    Key? key,
    required this.items,
    required this.cardType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Axis _direction = Axis.vertical;

    switch (cardType) {
      case CardType.small:
        _direction = Axis.horizontal;
        break;
      case CardType.medium:
        _direction = Axis.horizontal;
        break;
      default:
        _direction = Axis.vertical;
        break;
    }

    return _direction == Axis.vertical
        ? ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: items.length,
            itemBuilder: (context, index) => CustomCard(
              cardType: cardType,
              item: items[index],
            ),
          )
        : SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(
                items.length,
                (index) => CustomCard(
                  cardType: cardType,
                  item: items[index],
                ),
              ),
            ),
          );
  }
}
