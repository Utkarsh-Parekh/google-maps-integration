import 'package:flutter/material.dart';

class CustomBottomNavigationTheme{


  static BottomNavigationBarThemeData lightBottomNavigationTheme = BottomNavigationBarThemeData(
      backgroundColor: Colors.deepPurple.shade100,
      unselectedItemColor: Colors.grey,
      selectedItemColor: Colors.purple
  );

  static BottomNavigationBarThemeData darkBottomNavigationTheme =  const BottomNavigationBarThemeData(
      backgroundColor: Colors.deepPurple,
      unselectedItemColor: Colors.grey,
      selectedItemColor: Colors.white
  );
}