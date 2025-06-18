import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:teneffus/constants.dart';

ThemeData get theme => ThemeData(
      scaffoldBackgroundColor: Color(0xffF5F5F5),
      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: Color.fromRGBO(51, 51, 51, 1),
        selectionHandleColor: textFieldTextColor,
      ),
      colorScheme: const ColorScheme.light(
        primary: Color(0xfff5f5f5),
        onPrimary: Colors.white,
        surface: Colors.white,
        onSurface: Colors.black,
      ),
      textTheme: GoogleFonts.montserratTextTheme(const TextTheme(
          headlineMedium: TextStyle(fontSize: 30, color: Color(0xff212121)),
          headlineSmall: TextStyle(
              fontSize: 22,
              color: Color(0xff212121),
              fontWeight: FontWeight.w900),
          bodyLarge: TextStyle(
              fontSize: 18,
              color: Color(0xff212121),
              fontWeight: FontWeight.w900),
          bodyMedium: TextStyle(
              fontSize: 14,
              color: Color(0xff212121),
              fontWeight: FontWeight.w900),
          bodySmall: TextStyle(
              fontSize: 10,
              color: Color(0xff212121),
              fontWeight: FontWeight.w900))),
    );
