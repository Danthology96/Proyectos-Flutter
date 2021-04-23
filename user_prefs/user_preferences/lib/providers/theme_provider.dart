import 'package:flutter/material.dart';

var darkTheme = ThemeData(
  primaryColor: Color.fromRGBO(187, 134, 252, 1),
  accentColor: Color.fromRGBO(187, 134, 252, 1),
  brightness: Brightness.dark,
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: Color.fromRGBO(3, 218, 198, 1),
  ),
);
var lightTheme = ThemeData(
  primaryColor: Color.fromRGBO(98, 0, 238, 1),
  accentColor: Color.fromRGBO(98, 0, 238, 1),
  brightness: Brightness.light,
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: Color.fromRGBO(3, 218, 198, 1),
  ),
);

class ThemeChanger extends ChangeNotifier {
  ThemeData _themeData;
  ThemeChanger(this._themeData);

  get getTheme => _themeData;
  void setTheme(ThemeData theme) {
    _themeData = theme;
    notifyListeners();
  }
}
