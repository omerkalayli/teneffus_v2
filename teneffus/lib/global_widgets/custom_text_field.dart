import 'package:flutter/material.dart';
import 'package:teneffus/constants.dart';

/// [CustomTextField], is a custom text field with custom border colors and border radius.
/// A custom text field with custom border colors and border radius.
///
/// ### Parameters
/// - [controller]: The TextEditingController of the text field.
/// - [borderRadius]: The border radius of the text field. Default: 12.
/// - [color]: The color of the text field. Default: [textFieldColor].
/// - [enabledBorderColor]: The color of the text field border when enabled. Default: [textFieldEnabledBorderColor].
/// - [errorBorderColor]: The color of the text field border when an error occurs. Default: [textFieldErrorBorderColor].
/// - [focusedBorderColor]: The color of the text field border when focused. Default: [textFieldFocusedBorderColor].
/// - [textColor]: The color of the text field text. Default: [textFieldTextColor].
/// - [borderWidth]: The width of the text field border. Default: 2.
/// - [obscureText]: Whether the text field is obscured or not. Default: false.

class CustomTextField extends StatelessWidget {
  CustomTextField({
    required this.controller,
    BorderRadius? borderRadius,
    Color? color,
    Color? enabledBorderColor,
    Color? errorBorderColor,
    Color? focusedBorderColor,
    Color? textColor,
    double? borderWidth,
    bool? obscureText,
    super.key,
  })  : borderRadius = borderRadius ?? BorderRadius.circular(12),
        color = color ?? textFieldColor,
        enabledBorderColor = enabledBorderColor ?? textFieldEnabledBorderColor,
        errorBorderColor = errorBorderColor ?? textFieldErrorBorderColor,
        focusedBorderColor = focusedBorderColor ?? textFieldFocusedBorderColor,
        textColor = textColor ?? textFieldTextColor,
        borderWidth = borderWidth ?? 2,
        obscureText = obscureText ?? false;

  final BorderRadius borderRadius;
  final Color color;
  final Color enabledBorderColor;
  final Color errorBorderColor;
  final Color focusedBorderColor;
  final Color textColor;
  final double borderWidth;
  final TextEditingController controller;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: obscureText,
      controller: controller,
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
