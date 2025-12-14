import 'package:flutter/material.dart';
/// Provider global responsable du thème de l’application
/// Permet de basculer dynamiquement entre les thèmes
class MainProvider extends ChangeNotifier {
    /// Thème actuel de l’application
  ThemeData theme = ThemeData.light();
  /// Change le thème et notifie l’interface
  void setDarkMode(ThemeData thm) {
    theme = thm;
    notifyListeners();
  }
}