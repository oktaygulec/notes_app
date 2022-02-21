import 'package:flutter/material.dart';

import '/styles.dart';

enum AppBarMode { normal, onEdit }

enum IconPosition { left, right }

enum TitleType { pinned, all, recent, title }
enum ListType { category, note }
enum CardType { small, medium, large, long }
enum TextType {
  text,
  title,
  appBarTitle,
  button,
  subtitle,
  subtitleDate,
  cardTitleBold,
  cardTitleBoldZeroPadding,
  cardTitleMedium,
  cardTotalText,
  cardSubtitle,
  cardText,
  cardTextOnlyRightPadding,
  cardTextZeroPadding,
  iconSubtitle,
  countBar,
}

extension CardDirection on CardType {
  Axis get direction {
    switch (this) {
      case CardType.small:
        return Axis.horizontal;
      case CardType.medium:
        return Axis.horizontal;
      default:
        return Axis.vertical;
    }
  }
}

extension TextTypeStyle on TextType {
  TextStyle? get style {
    switch (this) {
      case TextType.text:
        return buildTheme().textTheme.bodyText1;
      case TextType.title:
        return buildTheme().textTheme.headline1;
      case TextType.appBarTitle:
        return buildTheme().textTheme.headline2;
      case TextType.button:
        return buildTheme().textTheme.button;
      case TextType.subtitle:
        return buildTheme().textTheme.subtitle1;
      case TextType.subtitleDate:
        return buildTheme().textTheme.subtitle2;
      case TextType.cardTitleMedium:
        return buildTheme()
            .textTheme
            .headline3!
            .copyWith(fontWeight: FontWeight.w500);
      case TextType.cardTitleBold:
        return buildTheme().textTheme.headline3;
      case TextType.cardTitleBoldZeroPadding:
        return buildTheme().textTheme.headline3;
      case TextType.cardText:
        return buildTheme().textTheme.headline4;
      case TextType.cardTextOnlyRightPadding:
        return buildTheme().textTheme.headline4;
      case TextType.cardTextZeroPadding:
        return buildTheme().textTheme.headline4;
      case TextType.cardTotalText:
        return buildTheme()
            .textTheme
            .headline4!
            .copyWith(fontWeight: FontWeight.w700);
      case TextType.cardSubtitle:
        return buildTheme().textTheme.headline5;
      case TextType.iconSubtitle:
        return buildTheme().textTheme.headline6;
      case TextType.countBar:
        return buildTheme().textTheme.overline;
      default:
        return buildTheme().textTheme.bodyText1;
    }
  }

  EdgeInsetsGeometry get padding {
    switch (this) {
      case TextType.appBarTitle:
        return EdgeInsets.zero;
      case TextType.cardSubtitle:
        return EdgeInsets.zero;
      case TextType.cardTotalText:
        return EdgeInsets.zero;
      case TextType.cardTitleMedium:
        return EdgeInsets.zero;
      case TextType.cardTitleBoldZeroPadding:
        return EdgeInsets.zero;
      case TextType.cardTextOnlyRightPadding:
        return const EdgeInsets.only(right: 8.0);
      case TextType.cardTextZeroPadding:
        return EdgeInsets.zero;
      case TextType.iconSubtitle:
        return EdgeInsets.zero;
      case TextType.countBar:
        return EdgeInsets.zero;
      default:
        return cardTextPadding;
    }
  }
}
