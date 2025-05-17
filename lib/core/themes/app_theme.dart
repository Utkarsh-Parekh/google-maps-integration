import 'package:demaze_practical/core/themes/appbar_theme.dart';
import 'package:demaze_practical/core/themes/bottomnavigation_theme.dart';
import 'package:demaze_practical/core/themes/elevatedbutton_theme.dart';
import 'package:demaze_practical/core/themes/inputdecoration_theme.dart';
import 'package:demaze_practical/core/themes/text_theme.dart';
import 'package:flutter/material.dart';

class AppThemes {
  //Light Theme
  static ThemeData lightTheme = ThemeData(
      brightness: Brightness.light,
      primaryColor: Colors.deepPurple.shade200,
      canvasColor: Colors.purple.shade400,
      textTheme: CustomTextTheme.lightTextTheme,
      appBarTheme: CustomAppBarTheme.lightAppBarTheme,
      elevatedButtonTheme: CustomElevatedButtonTheme.lightElavatedbuttonTheme,
      bottomNavigationBarTheme:
          CustomBottomNavigationTheme.lightBottomNavigationTheme,
      // outlinedButtonTheme: ,
      inputDecorationTheme: CustomInputDecorationTheme.lightInputDecoration,
      floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Colors.deepPurple.shade100,
          foregroundColor: Colors.black));

  //Dark Theme
  static ThemeData darkTheme = ThemeData(
      brightness: Brightness.dark,
      primaryColor: Colors.deepPurple,
      canvasColor: Colors.deepPurple,
      textTheme: CustomTextTheme.darkTextTheme,
      appBarTheme: CustomAppBarTheme.darkAppBarTheme,
      elevatedButtonTheme: CustomElevatedButtonTheme.darkElavatedbuttonTheme,
      bottomNavigationBarTheme:
          CustomBottomNavigationTheme.darkBottomNavigationTheme,
      inputDecorationTheme: CustomInputDecorationTheme.darkInputDecoration,
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Colors.deepPurple, foregroundColor: Colors.white));
}
