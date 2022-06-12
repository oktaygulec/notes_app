import 'package:flutter/material.dart';

const Color shrinePrimaryColor = Color(0xFFFEDBD0);
const Color shrinePrimaryVariantColor = Color(0xFFFFC2AE);
const Color shrineTextColor = Color(0xFF442C2E);
const Color shrineTextColorOpacity60 = Color(0x99442C2E);
const Color shrineTextColorOpacity35 = Color(0x59442C2E);
const Color shrineErrorColor = Color(0xFFC5032B);

const Color shrineBackgroundColor = Color(0xFFFFF0E8);
const Color shrineCardBackgroundColor = Colors.white;

const ColorScheme shrineColorScheme = ColorScheme(
  primary: shrinePrimaryColor,
  primaryContainer: shrinePrimaryVariantColor,
  secondary: shrineTextColor,
  secondaryContainer: shrineTextColor,
  surface: shrineCardBackgroundColor,
  background: shrineBackgroundColor,
  error: shrineErrorColor,
  onPrimary: shrineTextColor,
  onSecondary: shrinePrimaryColor,
  onSurface: shrineTextColor,
  onBackground: shrineTextColor,
  onError: Colors.white,
  brightness: Brightness.light,
);
