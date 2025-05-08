import 'package:flutter/material.dart';
import 'package:teneffus/gen/assets.gen.dart';

const Color navBarOrange = Color(0xffFF7043);

const Shadow headerShadow = Shadow(
    offset: Offset(0, 4), color: Color.fromARGB(64, 0, 0, 0), blurRadius: 4);

const Shadow textShadowSmall =
    Shadow(offset: Offset(0, 2), color: Color.fromARGB(64, 0, 0, 0));

const Curve slideAnimationCurve = Curves.linearToEaseOut;

/// ButtonPalette colors
const Color buttonBackgroundColorOrange = Color(0xffC26649);
const Color buttonForegroundColorOrange = Color(0xffFF8A65);

const Color buttonBackgroundColorWhite = Color(0xffB9B9B9);
const Color buttonForegroundColorWhite = Colors.white;

const Color buttonBackgroundColorBlue = Color(0xff4581B2);
const Color buttonForegroundColorBlue = Color(0xff64B5F6);

// TODO: these two must be specified
const Color buttonBackgroundColorRed = Color(0xffC26649);
const Color buttonForegroundColorRed = Color(0xffFF8A65);

const Color buttonBackgroundColorGreen = Color.fromARGB(255, 3, 130, 71);
const Color buttonForegroundColorGreen = Color(0xff00D600);

const Color buttonBackgroundColorYellow = Color(0xff94920D);
const Color buttonForegroundColorYellow = Colors.yellow;

/// Textfield colors
const Color textFieldTextColor = Color(0xff333333);
const Color textFieldEnabledBorderColor = Color(0xff058595);
const Color textFieldErrorBorderColor = Color(0xFFE57373);
const Color textFieldFocusedBorderColor = Color(0xff333333);
const Color textFieldColor = Color(0xffADE8F4);

// Snackbar colors

const Color snackbarErrorColor = Colors.redAccent;
const Color snackbarSuccessColor = Colors.green;
const Color snackbarInfoColor = Colors.blue;

const List<String> days = [
  "Pazartesi",
  "Salı",
  "Çarşamba",
  "Perşembe",
  "Cuma",
  "Cumartesi",
  "Pazar"
];

const List<int> dayStreakStars = [1, 2, 4, 8, 10, 12, 16];

const Duration animationDuration = Duration(milliseconds: 500);

Map<String, AssetGenImage> games = {
  "Eşleştirme": Assets.images.elestirme,
  "Dinleme": Assets.images.dinleme,
  "Cümle Kurma": Assets.images.cumleKurma,
  "Boşluk Doldurma": Assets.images.boslukDoldurma,
  "Konuşma": Assets.images.konusma,
};
