import 'package:flutter/material.dart';

class ThemeModel extends ChangeNotifier {
  Color _primaryColor = Colors.pink;

  Color get primaryColor => _primaryColor;

  void changeTheme(Color color) {
    _primaryColor = color;
    notifyListeners();
  }
}