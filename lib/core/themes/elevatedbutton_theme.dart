import 'package:flutter/material.dart';

class CustomElevatedButtonTheme {
  static ElevatedButtonThemeData lightElavatedbuttonTheme =
      ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.deepPurple.shade200,
      foregroundColor: Colors.white,
       textStyle: const TextStyle(fontSize: 16, color: Colors.black),
    ),
  );
  static ElevatedButtonThemeData darkElavatedbuttonTheme =
      ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.deepPurple,
      foregroundColor: Colors.white,
      textStyle: const TextStyle(color: Colors.black, fontSize: 16),
    ),
  );
}
