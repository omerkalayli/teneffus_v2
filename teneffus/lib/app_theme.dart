import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:teneffus/constants.dart';

ThemeData get theme => ThemeData(
      scaffoldBackgroundColor: Colors.transparent,
      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: Color.fromRGBO(51, 51, 51, 1),
        selectionHandleColor: textFieldTextColor,
      ),
      textTheme: GoogleFonts.montserratTextTheme(const TextTheme(
          headlineMedium: TextStyle(fontSize: 30, color: Colors.white),
          headlineSmall: TextStyle(
              fontSize: 22, color: Colors.white, fontWeight: FontWeight.w900),
          bodyLarge: TextStyle(
              fontSize: 18, color: Colors.white, fontWeight: FontWeight.w900),
          bodyMedium: TextStyle(
              fontSize: 14, color: Colors.white, fontWeight: FontWeight.w900),
          bodySmall: TextStyle(
              fontSize: 10, color: Colors.white, fontWeight: FontWeight.w900))),
    );
