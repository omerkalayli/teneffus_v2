import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:teneffus/constants.dart';
import 'package:teneffus/global_entities/button_type.dart';

part 'custom_button_methods.dart';

/// [CustomButton], is a customized button with a pressing effect.
///
/// ### Parameters
/// - [onPressed]: The function to be called when the button is pressed.
/// - [child]: The widget to be displayed inside the button.
/// - [borderWidth]: The width of the button border. Default: 2.
/// - [duration]: The duration of the button animation. Default: 200 milliseconds.
/// - [buttonPalette]: The type of the button. Default: orange.
/// - [buttonStrokeBorderRadius]: The border radius of the button stroke. Default: 10.
/// - [buttonBackgroundAndForegroundBorderRadius]: The border radius of the button background and foreground. Default: 7.
/// - [buttonOnPressedShadowBorderRadius]: The border radius of the button shadow when pressed. Default: 8.
/// - [showForegroundInnerShadow]: Whether to show the inner shadow on unpressed state as well. Default: false.
/// - [isSticky]: Whether the button should stay pressed until pressed again. Default: false.

class CustomButton extends HookConsumerWidget {
  CustomButton({
    required this.onPressed,
    required this.child,
    Duration? duration,
    double? borderWidth,
    ButtonPalette? buttonPalette,
    BorderRadius? buttonStrokeBorderRadius,
    BorderRadius? buttonBackgroundAndForegroundBorderRadius,
    BorderRadius? buttonOnPressedShadowBorderRadius,
    bool? showForegroundInnerShadow,
    bool? isSticky,
    this.value,
    super.key,
  })  : borderWidth = borderWidth ?? 2,
        duration = duration ?? const Duration(milliseconds: 200),
        buttonPalette = buttonPalette ?? ButtonPalette.orange(),
        buttonStrokeBorderRadius =
            buttonStrokeBorderRadius ?? BorderRadius.circular(10),
        buttonBackgroundAndForegroundBorderRadius =
            buttonBackgroundAndForegroundBorderRadius ??
                BorderRadius.circular(7),
        buttonOnPressedShadowBorderRadius =
            buttonOnPressedShadowBorderRadius ?? BorderRadius.circular(8),
        showForegroundInnerShadow = showForegroundInnerShadow ?? false,
        isSticky = isSticky ?? false;

  final Widget child;
  final Duration duration;
  final ButtonPalette buttonPalette;
  final BorderRadius buttonBackgroundAndForegroundBorderRadius;
  final BorderRadius buttonOnPressedShadowBorderRadius;
  final BorderRadius buttonStrokeBorderRadius;
  final double borderWidth;
  final bool showForegroundInnerShadow;
  final bool isSticky;
  final bool? value;
  final Function() onPressed;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isPressed = useState(false);

    if (value != null) {
      isPressed.value = value!;
    }

    return GestureDetector(
      onTap: () async {
        if (isSticky) {
          isPressed.value = !isPressed.value;
          if (isPressed.value) onPressed.call();
        } else {
          onPressed.call();
          isPressed.value = true;
          await Future.delayed(Durations.short1, () {
            isPressed.value = false;
          });
        }
      },
      onLongPressDown: (_) {
        if (!isSticky) isPressed.value = true;
      },
      onLongPressEnd: (_) {
        if (!isSticky) isPressed.value = false;
      },
      onHorizontalDragEnd: (_) {
        if (!isSticky) isPressed.value = false;
      },
      onVerticalDragEnd: (_) {
        if (!isSticky) isPressed.value = false;
      },
      child: Stack(
        children: [
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            top: 0,
            child: AnimatedContainer(
              /// Border layer of the button
              curve: Curves.fastEaseInToSlowEaseOut,
              margin: EdgeInsets.only(top: isPressed.value ? 8 : 0),
              duration: duration,
              decoration: BoxDecoration(
                  boxShadow: !isPressed.value
                      ? [
                          BoxShadow(
                              offset: const Offset(0, 4),
                              color: Colors.black.withValues(alpha: 0.3))
                        ]
                      : null,
                  borderRadius: buttonStrokeBorderRadius,
                  border: Border.all(width: borderWidth, color: Colors.black)),
              child: AnimatedContainer(
                /// Background layer of the button
                curve: Curves.fastEaseInToSlowEaseOut,
                duration: duration,
                margin: EdgeInsets.only(
                  top: isPressed.value ? borderWidth + 8 : borderWidth + 2,
                  bottom: isPressed.value ? borderWidth + 2 : 0,
                ),
                decoration: BoxDecoration(
                  borderRadius: buttonBackgroundAndForegroundBorderRadius,
                  color: _getButtonBackgroundColor(buttonPalette),
                ),
              ),
            ),
          ),
          AnimatedContainer(
            /// Foreground layer of the button
            curve: Curves.fastEaseInToSlowEaseOut,
            duration: duration,
            margin: EdgeInsets.only(
                left: borderWidth,
                right: borderWidth,
                bottom: isPressed.value ? borderWidth : 8,
                top: isPressed.value ? borderWidth + 8 : borderWidth),
            decoration: BoxDecoration(
              borderRadius: buttonBackgroundAndForegroundBorderRadius,
              color: _getButtonForegroundColor(buttonPalette),
            ),
            child: AnimatedContainer(

                /// Child layer of the button
                margin: EdgeInsets.all(borderWidth + 4),
                duration: duration,
                decoration: BoxDecoration(
                    borderRadius: buttonOnPressedShadowBorderRadius,
                    color: isPressed.value || showForegroundInnerShadow
                        ? Colors.black.withValues(alpha: 0.2)
                        : Colors.transparent),
                child: Center(child: child)),
          ),
        ],
      ),
    );
  }
}
