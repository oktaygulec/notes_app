import 'package:flutter/material.dart';

import '/enums.dart';

class AppBarStatus with ChangeNotifier {
  AppBarMode _mode = AppBarMode.normal;
  AppBarMode get mode => _mode;

  dynamic _item;
  dynamic get item => _item;

  void changeMode(AppBarMode mode) {
    _mode = mode;
    notifyListeners();
  }

  void setItem(dynamic item) {
    _item = item;
    notifyListeners();
  }
}
