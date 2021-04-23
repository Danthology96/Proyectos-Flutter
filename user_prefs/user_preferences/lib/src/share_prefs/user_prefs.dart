import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_preferences/providers/theme_provider.dart';
import 'package:user_preferences/src/pages/home_Page.dart';

class UserPrefs {
  static final UserPrefs _instance = new UserPrefs._internal();

  factory UserPrefs() {
    return _instance;
  }

  UserPrefs._internal();

  SharedPreferences _prefs;

  initPrefs() async {
    this._prefs = await SharedPreferences.getInstance();
  }

  //ninguna de las propiedades se usa
  //bool _darkMode;
  // int _gender;
  // String _name;

  //GET & SET DE LOS GENEROS

  get gender {
    return _prefs.getInt('gender') ?? 1;
  }

  set setGender(int value) {
    _prefs.setInt('gender', value);
  }
  //GET & SET DEL DARKMODE

  get darkMode {
    return _prefs.getBool('darkMode') ?? false;
  }

  set setDarkMode(bool value) {
    _prefs.setBool('darkMode', value);
  }

  //GET & SET DEL NOMBRE

  get name {
    return _prefs.getString('name') ?? '';
  }

  set setName(String value) {
    _prefs.setString('name', value);
  }

  //GET & SET DEL LASPAGE

  get lastPage {
    return _prefs.getString('lastPage') ?? HomePage.routeName;
  }

  set setLastPage(String value) {
    _prefs.setString('lastPage', value);
  }
}
