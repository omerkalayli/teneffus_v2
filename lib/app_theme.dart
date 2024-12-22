import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData get theme => ThemeData(
      scaffoldBackgroundColor: const Color(0xff4DD0E1),
      textTheme: GoogleFonts.montserratTextTheme(const TextTheme(
          headlineMedium: TextStyle(fontSize: 36, color: Colors.white),
          headlineSmall: TextStyle(
              fontSize: 24, color: Colors.white, fontWeight: FontWeight.w900),
          bodyLarge: TextStyle(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.w900),
          bodyMedium: TextStyle(
              fontSize: 16, color: Colors.white, fontWeight: FontWeight.w900),
          bodySmall: TextStyle(
              fontSize: 12, color: Colors.white, fontWeight: FontWeight.w900))),
    );
