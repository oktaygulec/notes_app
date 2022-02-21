import 'package:flutter/material.dart';

import '/enums.dart';
import '/styles.dart';
import '/widgets/components/custom_text.dart';

class IconText extends StatelessWidget {
  final Icon icon;
  final String text;
  final TextType? textType;
  final IconPosition? iconPosition;

  const IconText({
    Key? key,
    required this.text,
    required this.icon,
    this.textType,
    this.iconPosition = IconPosition.left,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: iconPosition == IconPosition.left
          ? [
              Padding(
                padding: EdgeInsets.only(right: iconTextPadding.horizontal),
                child: icon,
              ),
              CustomText(
                text,
                alignment: TextAlign.left,
                textType: textType,
              ),
            ]
          : [
              CustomText(
                text,
                alignment: TextAlign.left,
                textType: textType,
              ),
              Padding(
                padding: EdgeInsets.only(left: iconTextPadding.horizontal),
                child: icon,
              ),
            ],
    );
  }
}
