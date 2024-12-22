import 'package:flutter/material.dart';
import 'package:teneffus/constants.dart';

/// [CustomTextField], is a custom text field with custom border colors and border radius.
/// A custom text field with custom border colors and border radius.
///
/// ### Parameters
/// - [borderRadius]: The border radius of the text field. Default: [textFieldBorderRadius].
/// - [color]: The color of the text field. Default: [textFieldColor].
/// - [enabledBorderColor]: The color of the text field border when enabled. Default: [textFieldEnabledBorderColor].
/// - [errorBorderColor]: The color of the text field border when an error occurs. Default: [textFieldErrorBorderColor].
/// - [focusedBorderColor]: The color of the text field border when focused. Default: [textFieldFocusedBorderColor].
/// - [textColor]: The color of the text field text. Default: [textFieldTextColor].
/// - [borderWidth]: The width of the text field border. Default: [textFieldStrokeWidth].

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    BorderRadius? borderRadius,
    Color? color,
    Color? enabledBorderColor,
    Color? errorBorderColor,
    Color? focusedBorderColor,
    Color? textColor,
    double? borderWidth,
    super.key,
  })  : borderRadius = borderRadius ?? textFieldBorderRadius,
        color = color ?? textFieldColor,
        enabledBorderColor = enabledBorderColor ?? textFieldEnabledBorderColor,
        errorBorderColor = errorBorderColor ?? textFieldErrorBorderColor,
        focusedBorderColor = focusedBorderColor ?? textFieldFocusedBorderColor,
        textColor = textColor ?? textFieldTextColor,
        borderWidth = borderWidth ?? textFieldStrokeWidth;

  final BorderRadius borderRadius;
  final Color color;
  final Color enabledBorderColor;
  final Color errorBorderColor;
  final Color focusedBorderColor;
  final Color textColor;
  final double borderWidth;

  @override
  Widget build(BuildContext context) {
    return TextField(
      cursorColor: textColor,
      style: TextStyle(color: textColor),
      decoration: InputDecoration(
        errorBorder: OutlineInputBorder(
            borderRadius: borderRadius,
            borderSide:
                BorderSide(width: borderWidth, color: errorBorderColor)),
        enabledBorder: OutlineInputBorder(
            borderRadius: borderRadius,
            borderSide:
                BorderSide(width: borderWidth, color: enabledBorderColor)),
        focusedBorder: OutlineInputBorder(
            borderRadius: borderRadius,
            borderSide:
                BorderSide(width: borderWidth, color: focusedBorderColor)),
        filled: true,
        fillColor: color,
      ),
    );
  }
}
