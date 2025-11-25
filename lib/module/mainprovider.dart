import 'package:flutter/material.dart';

class MainProvider extends ChangeNotifier {
  ThemeData theme = ThemeData.light();

  void setDarkMode(ThemeData thm) {
    theme = thm;
    notifyListeners();
  }
}