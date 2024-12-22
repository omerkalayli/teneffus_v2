import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:teneffus/constants.dart';
import 'package:teneffus/global_entities/button_type.dart';
import 'package:teneffus/global_widgets/custom_button.dart';

part 'custom_circular_button_methods.dart';

/// [CustomCircularButton], is a customized circular button with a pressing effect.
/// This button uses [CustomButton] as a base.
///
/// Background color and border color are set to black. To change this, use [ButtonPalette.custom]
/// To get the perfect circular shape, the height of the parent widget must be 8 pixels more than the width.
///
/// ### Parameters
/// - [onPressed]: The function to be called when the button is pressed.
/// - [child]: The widget to be displayed inside the button.
/// - [borderWidth]: The width of the button border. Default: 2.
/// - [duration]: The duration of the button animation. Default: 200 milliseconds.
/// - [buttonPalette]: The type of the button. Default: orange.
/// - [showForegroundInnerShadow]: Whether to show the inner shadow on unpressed state as well. Default: false.
/// - [isSticky]: Whether the button should stay pressed until pressed again. Default: false.
/// - [value]: The value to be used in the [isSticky] mode. Default: false.

class CustomCircularButton extends HookConsumerWidget {
  const CustomCircularButton({
    required this.onPressed,
    required this.child,
    this.duration,
    this.borderWidth,
    this.buttonPalette,
    this.value,
    bool? showForegroundInnerShadow,
    bool? isSticky,
    super.key,
  })  : isSticky = isSticky ?? false,
        showForegroundInnerShadow = showForegroundInnerShadow ?? false;

  final Widget child;
  final Duration? duration;
  final ButtonPalette? buttonPalette;
  final double? borderWidth;
  final bool? value;
  final bool showForegroundInnerShadow;
  final bool isSticky;
  final Function() onPressed;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CustomButton(
        buttonPalette: ButtonPalette.custom(
          backgroundColor: Colors.black,
          foregroundColor: _getButtonForegroundColor(buttonPalette),
        ),
        backgroundAndForegroundBorderRadius: BorderRadius.circular(30),
        strokeBorderRadius: BorderRadius.circular(30),
        onPressedShadowBorderRadius: BorderRadius.circular(99),
        onPressed: onPressed,
        showForegroundInnerShadow: showForegroundInnerShadow,
        isSticky: isSticky,
        value: value,
        child: child);
  }
}
