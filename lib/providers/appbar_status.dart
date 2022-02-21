import 'package:flutter/material.dart';
import '/enums.dart';

class AppBarStatus with ChangeNotifier {
  AppBarMode _mode = AppBarMode.normal;
  AppBarMode get mode => _mode;

  void changeMode(AppBarMode mode) {
    _mode = mode;
    notifyListeners();
  }
}
