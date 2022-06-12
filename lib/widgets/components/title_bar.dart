import 'package:flutter/material.dart';

import '/enums.dart';
import '/styles.dart';
import '/widgets/components/custom_text.dart';
import '/widgets/components/icon_text.dart';

class TitleBar extends StatelessWidget {
  final Icon icon;
  final String title;
  final int amount;

  const TitleBar({
    Key? key,
    required this.icon,
    required this.title,
    required this.amount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: defaultPadding,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconText(
            icon: Icon(
              icon.icon,
              color: textColorOpacity60,
            ),
            text: title,
            textType: TextType.iconSubtitle,
          ),
          Container(
            width: 40,
            height: 20,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(
                Radius.circular(
                  countBarBorderRadius,
                ),
              ),
              color: TextType.countBar.style!.backgroundColor,
            ),
            child: Center(
              child: CustomText(
                amount.toString(),
                textType: TextType.countBar,
              ),
            ),
          )
        ],
      ),
    );
  }
}
