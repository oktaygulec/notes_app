import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:intl/intl.dart';
import 'package:notesapp/screens/notes/category_details_screen.dart';
import 'package:provider/provider.dart';

import '/enums.dart';
import '/styles.dart';
import '/models/category.dart';
import '/models/note.dart';
import '/providers/appbar_status.dart';
import '/widgets/components/custom_text.dart';
import '/screens/notes/note_details_screen.dart';

class CustomCard extends StatelessWidget {
  final dynamic item;
  final CardType cardType;

  const CustomCard({
    Key? key,
    required this.item,
    required this.cardType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: cardType.direction == Axis.horizontal
          ? cardHorizontalMargin
          : cardVerticalMargin,
      child: InkWell(
        highlightColor: primaryColor,
        splashColor: primaryVariantColor,
        borderRadius:
            const BorderRadius.all(Radius.circular(defaultBorderRadius)),
        onLongPress: () {
          final prov = Provider.of<AppBarStatus>(context, listen: false);
          prov.changeMode(AppBarMode.onEdit);
          prov.setItem(item);
        },
        onTap: () {
          Navigator.of(context).pushNamed(
              item.runtimeType == Note
                  ? NoteDetailsScreen.routeName
                  : CategoryDetailsScreen.routeName,
              arguments: item);
        },
        child: Padding(
          padding: cardPadding,
          child: _cardCheck(cardType, item),
        ),
      ),
    );
  }

  Widget? _cardCheck(CardType cardType, dynamic item) {
    switch (cardType) {
      case CardType.small:
        return SizedBox(
          width: 150,
          child: _smallCard(item),
        );
      case CardType.medium:
        return ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 175,
            maxHeight: 150,
          ),
          child: _mediumCard(item),
        );
      case CardType.large:
        return _mediumCard(item);
      case CardType.long:
        return _longCard(item);
      default:
        return Column(
          children: [
            CustomText(
              item.title,
              textType: TextType.cardTitleBold,
            ),
            CustomText(
              Document.fromJson(
                json.decode(item.description),
              ).toPlainText(),
              textType: TextType.cardTitleBold,
            ),
            Row(
              children: [
                Icon(
                  Icons.history,
                  color: TextType.cardSubtitle.style!.color,
                ),
                CustomText(
                  DateFormat('dd MMM').format(item.createdTime),
                  textType: TextType.cardSubtitle,
                ),
              ],
            ),
          ],
        );
    }
  }

  Widget _smallCard(Category item) {
    var length = 0;
    if (item.notes != null) {
      length = item.notes!.length;
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          item.title,
          textType: TextType.cardTitleBold,
        ),
        SizedBox(
          height: smallCardTextPadding.vertical,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const CustomText(
              "Total Notes:",
              textType: TextType.cardTextZeroPadding,
            ),
            CustomText(
              length.toString(),
              textType: TextType.cardTotalText,
            ),
          ],
        ),
      ],
    );
  }

  Widget _mediumCard(Note item) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          item.title,
          textType: TextType.cardTitleBold,
        ),
        CustomText(
          Document.fromJson(
            jsonDecode(item.description),
          ).toPlainText(),
          textType: TextType.cardText,
          maxLines: 4,
        ),
        Row(
          children: [
            Icon(
              Icons.history,
              color: TextType.cardSubtitle.style!.color,
            ),
            SizedBox(
              width: iconTextPadding.horizontal,
            ),
            CustomText(
              DateFormat('dd MMM').format(item.createdTime),
              textType: TextType.cardSubtitle,
            ),
          ],
        ),
      ],
    );
  }

  Widget _longCard(Category item) {
    var length = 0;
    if (item.notes != null) {
      length = item.notes!.length;
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CustomText(
          item.title,
          textType: TextType.cardTitleBoldZeroPadding,
        ),
        CustomText(
          "${length.toString()} Notes",
          textType: TextType.cardTextZeroPadding,
        ),
      ],
    );
  }
}
