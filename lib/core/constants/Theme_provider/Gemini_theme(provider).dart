import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  bool _darkModeEnabled = false;

  bool get darkModeEnabled => _darkModeEnabled;

  set darkModeEnabled(bool value) {
    _darkModeEnabled = value;
    notifyListeners();
  }
}
