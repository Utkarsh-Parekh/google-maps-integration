import 'package:flutter/material.dart';


//Provides theme preference
class ThemeProvider extends ChangeNotifier{

  ThemeMode _themeData = ThemeMode.dark;

  get themedata => _themeData;

  void toggleTheme(bool isDarkMode){
    _themeData = isDarkMode ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

}