import 'dart:ui';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'button_type.freezed.dart';

@freezed
class ButtonPalette with _$ButtonPalette {
  factory ButtonPalette.orange() = _Orange;
  factory ButtonPalette.green() = _Green;
  factory ButtonPalette.red() = _Red;
  factory ButtonPalette.white() = _White;
  factory ButtonPalette.blue() = _Blue;
  factory ButtonPalette.yellow() = _Yellow;
  factory ButtonPalette.gray() = _Gray;
  factory ButtonPalette.purple() = _Purple;
  factory ButtonPalette.teal() = _Teal;
  factory ButtonPalette.darkCyan() = _DarkCyan;
  factory ButtonPalette.deepOrange() = _DeepOrange;
  factory ButtonPalette.indigo() = _Indigo;
  factory ButtonPalette.forestGreen() = _ForestGreen;
  factory ButtonPalette.maroon() = _Maroon;
  factory ButtonPalette.midnightBlue() = _MidnightBlue;
  factory ButtonPalette.burntSienna() = _BurntSienna;
  factory ButtonPalette.slateGray() = _SlateGray;
  factory ButtonPalette.olive() = _Olive;
  factory ButtonPalette.darkMagenta() = _DarkMagenta;

  factory ButtonPalette.custom(
      {required Color foregroundColor,
      required Color backgroundColor}) = _Custom;
}
