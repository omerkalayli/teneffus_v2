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
  factory ButtonPalette.custom(
      {required Color foregroundColor,
      required Color backgroundColor}) = _Custom;
}
