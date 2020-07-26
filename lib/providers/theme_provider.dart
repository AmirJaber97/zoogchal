import 'package:flutter/material.dart';
import 'package:zoog/app/locator.dart';
import 'package:zoog/caches/preferences.dart';

class ThemeProvider extends ChangeNotifier {
  Preferences preferences = locator<Preferences>();

  bool get darkTheme => preferences.darkMode();

  set darkTheme(bool value) {
    preferences.setDarkMode(value);
    notifyListeners();
  }
}
