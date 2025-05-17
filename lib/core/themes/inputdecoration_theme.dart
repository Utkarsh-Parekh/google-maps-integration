import 'package:flutter/material.dart';

class CustomInputDecorationTheme {
  static InputDecorationTheme lightInputDecoration = InputDecorationTheme(
    border: const OutlineInputBorder(),
    prefixIconColor: Colors.black,
    focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(width: 2, color: Colors.black),
        borderRadius: BorderRadius.circular(10)),
    enabledBorder: OutlineInputBorder(
      borderSide: const BorderSide(width: 2, color: Colors.black),
      borderRadius: BorderRadius.circular(10),
    ),
  );

  static InputDecorationTheme darkInputDecoration = InputDecorationTheme(
      border: const OutlineInputBorder(),
      prefixIconColor: Colors.purple,
      focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 2, color: Colors.white),
          borderRadius: BorderRadius.circular(10)),
      enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 2, color: Colors.white),
          borderRadius: BorderRadius.circular(10)));
}
