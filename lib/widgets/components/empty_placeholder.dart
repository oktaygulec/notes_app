import 'package:flutter/material.dart';

import '/enums.dart';
import '/widgets/components/custom_text.dart';
import '/widgets/components/icon_text.dart';

class EmptyPlaceholder extends StatelessWidget {
  final String text;
  final IconData icon;
  final String buttonText;
  final VoidCallback? buttonOnPress;
  const EmptyPlaceholder({
    Key? key,
    required this.text,
    required this.icon,
    required this.buttonText,
    required this.buttonOnPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: TextType.emptyPlaceholder.style!.color,
            size: 128,
          ),
          const SizedBox(
            height: 16,
          ),
          CustomText(
            text,
            alignment: TextAlign.center,
            textType: TextType.emptyPlaceholder,
          ),
          const SizedBox(
            height: 16,
          ),
          ElevatedButton(
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: IconText(
                icon: const Icon(Icons.add),
                text: buttonText.toUpperCase(),
                textType: TextType.secondaryButton,
                iconPosition: IconPosition.left,
                isStretched: false,
              ),
            ),
            onPressed: buttonOnPress,
          ),
        ],
      ),
    );
  }
}
