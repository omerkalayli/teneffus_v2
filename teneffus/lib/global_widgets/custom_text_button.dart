import 'package:flutter/material.dart';
import 'package:teneffus/global_entities/button_type.dart';
import 'package:teneffus/global_widgets/custom_button.dart';
import 'package:teneffus/global_widgets/stroked_text.dart';

/// [CustomTextButton], is a customized text button with a pressing effect.
/// This button uses [CustomButton] as a base.
///
/// Parameters:
/// - [text]: The text to be displayed inside the button.
/// - [onPressed]: The function to be called when the button is pressed.
/// - [borderWidth]: The width of the button border. The default value is located in the [CustomButton].
/// - [buttonBackgroundAndForegroundBorderRadius]: The border radius of the button background and foreground. The default value is located in the [CustomButton].
/// - [buttonOnPressedShadowBorderRadius]: The border radius of the button shadow when pressed. The default value is located in the [CustomButton].
/// - [fontSize]: The font size of the text.

class CustomTextButton extends StatelessWidget {
  const CustomTextButton({
    required this.text,
    required this.onPressed,
    this.borderWidth,
    this.buttonBackgroundAndForegroundBorderRadius,
    this.buttonOnPressedShadowBorderRadius,
    this.buttonStrokeBorderRadius,
    this.buttonPalette,
    this.duration,
    this.fontSize,
    super.key,
  });

  final double? borderWidth;
  final BorderRadius? buttonBackgroundAndForegroundBorderRadius;
  final BorderRadius? buttonOnPressedShadowBorderRadius;
  final BorderRadius? buttonStrokeBorderRadius;
  final ButtonPalette? buttonPalette;
  final Duration? duration;
  final double? fontSize;

  final String text;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      borderWidth: borderWidth,
      buttonBackgroundAndForegroundBorderRadius:
          buttonBackgroundAndForegroundBorderRadius,
      buttonOnPressedShadowBorderRadius: buttonOnPressedShadowBorderRadius,
      buttonStrokeBorderRadius: buttonStrokeBorderRadius,
      buttonPalette: buttonPalette,
      duration: duration,
      child: StrokedText(
        text,
        strokeWidth: 2,
        style: Theme.of(context)
            .textTheme
            .bodyLarge!
            .copyWith(color: Colors.white, fontSize: fontSize),
      ),
      onPressed: () {
        onPressed.call();
      },
    );
  }
}
