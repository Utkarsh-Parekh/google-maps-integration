import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextTheme {
  static TextTheme lightTextTheme = TextTheme(
      bodyLarge: GoogleFonts.poppins(color: Colors.black, fontSize: 16),
      bodySmall: GoogleFonts.poppins(color: Colors.black, fontSize: 14),
      bodyMedium: GoogleFonts.poppins(color: Colors.black, fontSize: 14),
      titleLarge: GoogleFonts.poppins(color: Colors.black, fontSize: 20));
  static TextTheme darkTextTheme = TextTheme(
    bodyLarge: GoogleFonts.poppins(color: Colors.white, fontSize: 16),
    bodyMedium: GoogleFonts.poppins(color: Colors.white, fontSize: 14),
    titleLarge: GoogleFonts.poppins(color: Colors.white, fontSize: 20),
    bodySmall: GoogleFonts.poppins(color: Colors.white, fontSize: 14),
  );
}
