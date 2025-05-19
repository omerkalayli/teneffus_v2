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

const Color buttonBackgroundColorPurple = Color(0xff7E57C2);
const Color buttonForegroundColorPurple = Color(0xffB39DDB);

const Color buttonBackgroundColorTeal = Color(0xff00796B);
const Color buttonForegroundColorTeal = Color(0xff33A99A);

const Color buttonBackgroundColorRed = Color(0xffE53935);
const Color buttonForegroundColorRed = Color(0xffEF9A9A);

const Color buttonBackgroundColorMidnightBlue = Color(0xff003366);
const Color buttonForegroundColorMidnightBlue = Color(0xff6699CC);

const Color buttonBackgroundColorBurntSienna = Color(0xff8A3B12);
const Color buttonForegroundColorBurntSienna = Color(0xffD2691E);

const Color buttonBackgroundColorSlateGray = Color(0xff455A64);
const Color buttonForegroundColorSlateGray = Color(0xff90A4AE);

const Color buttonBackgroundColorOlive = Color(0xff556B2F);
const Color buttonForegroundColorOlive = Color(0xffBDB76B);

const Color buttonBackgroundColorDarkMagenta = Color(0xff8B008B);
const Color buttonForegroundColorDarkMagenta = Color(0xffD580FF);

const Color buttonBackgroundColorGreen = Color.fromARGB(255, 3, 130, 71);
const Color buttonForegroundColorGreen = Color(0xff00D600);

const Color buttonBackgroundColorYellow = Color(0xff94920D);
const Color buttonForegroundColorYellow = Colors.yellow;

const Color buttonBackgroundColorGrey = Color(0xFF616161);
const Color buttonForegroundColorGrey = Color(0xFFE0E0E0);

const Color buttonBackgroundColorDarkCyan = Color(0xff00675B);
const Color buttonForegroundColorDarkCyan = Color(0xff4DB6AC);

const Color buttonBackgroundColorDeepOrange = Color(0xffD84315);
const Color buttonForegroundColorDeepOrange = Color(0xffff7043);

const Color buttonBackgroundColorIndigo = Color(0xff3949AB);
const Color buttonForegroundColorIndigo = Color(0xff9FA8DA);

const Color buttonBackgroundColorForestGreen = Color(0xff2E7D32);
const Color buttonForegroundColorForestGreen = Color(0xff81C784);

const Color buttonBackgroundColorMaroon = Color(0xff6A1B9A);
const Color buttonForegroundColorMaroon = Color(0xffCE93D8);

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

const String correctSoundPath = "assets/sounds/correct.mp3";
const String wrongSoundPath = "assets/sounds/wrong.mp3";
const String gameOverSoundPath = "assets/sounds/game_finish.mp3";
const String failureSoundPath = "assets/sounds/failure.mp3";
const String clickSoundPath = "assets/sounds/click.mp3";
const String dropWordSoundPath = "assets/sounds/drop_word.mp3";
const String putWordSoundPath = "assets/sounds/put_word.mp3";

const LinearGradient flipCardGradient = LinearGradient(
  begin: Alignment.bottomCenter,
  end: Alignment.topCenter,
  colors: [
    Color(0xFF0D47A1),
    Color(0xFF1565C0),
  ],
);

const BoxDecoration homeworkCardHeaderDecoration = BoxDecoration(
  color: Colors.blueGrey,
  borderRadius: BorderRadius.only(
    topLeft: Radius.circular(8),
    topRight: Radius.circular(8),
  ),
);
