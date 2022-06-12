import 'package:flutter/material.dart';

import '/enums.dart';

class CustomText extends StatelessWidget {
  final String text;
  final TextAlign alignment;
  final TextType textType;
  final int maxLines;
  final TextOverflow? overflow;

  const CustomText(
    this.text, {
    Key? key,
    this.alignment = TextAlign.justify,
    this.textType = TextType.text,
    this.maxLines = 4,
    this.overflow,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: textType.padding,
      child: Text(
        text,
        style: textType.style,
        maxLines: maxLines,
        overflow: overflow,
        textAlign: alignment,
      ),
    );
  }
}
