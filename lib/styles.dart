import 'package:flutter/material.dart';

const Color primaryColor = Color(0xFFFEDBD0);
const Color primaryVariantColor = Color(0xFFFFC2AE);
const Color textColor = Color(0xFF442C2E);
const Color textColorOpacity60 = Color(0x99442C2E);
const Color textColorOpacity35 = Color(0x59442C2E);
const Color errorColor = Color(0xFFC5032B);

const Color backgroundColor = Color(0xFFFFF0E8);
const Color cardBackgroundColor = Colors.white;

const double defaultBorderRadius = 8.0;
const double countBarBorderRadius = 12.0;

const EdgeInsetsGeometry defaultPadding =
    EdgeInsets.symmetric(horizontal: 12.0, vertical: 16.0);
const EdgeInsetsGeometry checkboxItemPadding = EdgeInsets.symmetric(
  vertical: 5.0,
);

const EdgeInsetsGeometry cardPadding = EdgeInsets.all(16.0);
const EdgeInsetsGeometry cardVerticalMargin = EdgeInsets.only(
  left: 12.0,
  right: 12.0,
  bottom: 16.0,
);
const EdgeInsetsGeometry cardHorizontalMargin = EdgeInsets.only(
  left: 12.0,
  right: 4.0,
  bottom: 2.0,
);

const EdgeInsetsGeometry cardTextPadding = EdgeInsets.only(
  bottom: 16.0,
);
const EdgeInsetsGeometry smallCardTextPadding = EdgeInsets.only(bottom: 24.0);
const EdgeInsetsGeometry iconTextPadding = EdgeInsets.only(right: 8.0);

const defaultLetterSpacing = 0.03;

ThemeData buildTheme() {
  final ThemeData base = ThemeData.light();
  return base.copyWith(
    primaryColor: primaryColor,
    scaffoldBackgroundColor: backgroundColor,
    cardColor: cardBackgroundColor,
    errorColor: errorColor,
    buttonTheme: const ButtonThemeData(
      colorScheme: _colorScheme,
      textTheme: ButtonTextTheme.normal,
    ),
    cardTheme: base.cardTheme.copyWith(
      color: cardBackgroundColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(defaultBorderRadius),
        ),
      ),
    ),
    primaryIconTheme: _customIconTheme(base.iconTheme),
    textTheme: _buildTextTheme(base.textTheme),
    primaryTextTheme: _buildTextTheme(base.primaryTextTheme),
    iconTheme: _customIconTheme(base.iconTheme),
    colorScheme: _colorScheme,
    tabBarTheme: _customTabBarTheme(base.tabBarTheme),
    bottomNavigationBarTheme:
        _customBottomNavigationBarTheme(base.bottomNavigationBarTheme),
    textSelectionTheme:
        base.textSelectionTheme.copyWith(cursorColor: textColor),
    inputDecorationTheme: base.inputDecorationTheme.copyWith(
      labelStyle: const TextStyle(color: textColor),
      focusedBorder: const UnderlineInputBorder(
        borderSide: BorderSide(
          width: 1,
          color: textColor,
        ),
      ),
    ),
    dialogBackgroundColor: primaryColor,
  );
}

BottomNavigationBarThemeData _customBottomNavigationBarTheme(
    BottomNavigationBarThemeData base) {
  return base.copyWith(
    backgroundColor: primaryColor,
    selectedItemColor: textColor,
    unselectedItemColor: textColorOpacity60,
    unselectedLabelStyle: const TextStyle(fontSize: 14.0),
  );
}

TabBarTheme _customTabBarTheme(TabBarTheme base) {
  return base.copyWith(
      labelStyle: const TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 14.0,
        color: textColor,
      ),
      unselectedLabelStyle: const TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 14.0,
        color: textColorOpacity60,
      ),
      indicator: const UnderlineTabIndicator(
        borderSide: BorderSide(width: 2.0, color: textColor),
      ));
}

IconThemeData _customIconTheme(IconThemeData original) {
  return original.copyWith(color: textColor, size: 24);
}

TextTheme _buildTextTheme(TextTheme base) {
  final TextTheme theme = base.copyWith(
    bodyText1: const TextStyle(
      fontFamily: 'Roboto',
      fontWeight: FontWeight.w400,
      fontSize: 16.0,
      color: textColor,
      letterSpacing: defaultLetterSpacing,
    ),
  );

  return theme.copyWith(
    // Regular Text
    bodyText1: theme.bodyText1,
    caption: theme.bodyText1,

    // Title
    headline1: theme.bodyText1?.copyWith(
      fontWeight: FontWeight.w700,
      fontSize: 24.0,
    ),

    // AppBar Title
    headline2: theme.bodyText1?.copyWith(
      fontFamily: 'Rubik',
      fontWeight: FontWeight.w500,
      fontSize: 18.0,
      letterSpacing: 3,
    ),

    // Card Title
    headline3: theme.bodyText1?.copyWith(
      fontWeight: FontWeight.w700,
      fontSize: 20.0,
    ),

    // Card Text
    headline4: theme.bodyText1?.copyWith(
      fontWeight: FontWeight.w400,
      fontSize: 14.0,
    ),

    // Card Subtitle
    headline5: theme.bodyText1?.copyWith(
      fontWeight: FontWeight.w700,
      fontSize: 12.0,
      color: textColorOpacity35,
    ),

    // Icon Subtitle
    headline6: theme.bodyText1?.copyWith(
      fontWeight: FontWeight.w700,
      fontSize: 14.0,
      color: textColorOpacity60,
    ),

    // Button
    button: theme.bodyText1?.copyWith(
      fontWeight: FontWeight.w700,
      fontSize: 14.0,
      color: primaryColor,
    ),

    // Subtitle
    subtitle1: theme.bodyText1?.copyWith(
      fontWeight: FontWeight.w500,
      fontSize: 20.0,
    ),

    // Subtitle Date
    subtitle2: theme.bodyText1?.copyWith(
      fontWeight: FontWeight.w500,
      fontSize: 14.0,
      color: textColorOpacity60,
    ),

    // Count Bar Text
    overline: theme.bodyText1?.copyWith(
      backgroundColor: textColor,
      fontWeight: FontWeight.w700,
      fontSize: 14.0,
      color: primaryColor,
    ),
  );
}

const ColorScheme _colorScheme = ColorScheme(
  primary: primaryColor,
  primaryContainer: primaryVariantColor,
  secondary: textColor,
  secondaryContainer: textColor,
  surface: backgroundColor,
  background: backgroundColor,
  error: errorColor,
  onPrimary: textColor,
  onSecondary: primaryColor,
  onSurface: textColor,
  onBackground: textColor,
  onError: Colors.white,
  brightness: Brightness.light,
);
