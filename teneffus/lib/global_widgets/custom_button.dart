import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:teneffus/constants.dart';
import 'package:teneffus/global_entities/button_type.dart';
import 'package:teneffus/sound_manager.dart';

part 'custom_button_methods.dart';

class CustomButton extends HookConsumerWidget {
  CustomButton({
    required this.onPressed,
    required this.child,
    this.disableSound = false,
    Duration? duration,
    double? borderWidth,
    ButtonPalette? buttonPalette,
    BorderRadius? buttonStrokeBorderRadius,
    BorderRadius? buttonBackgroundAndForegroundBorderRadius,
    BorderRadius? buttonOnPressedShadowBorderRadius,
    bool? showForegroundInnerShadow,
    this.disableOnPressedForegroundColor = false,
    bool? isShadowDisabled,
    Color? borderColor,
    bool? isSticky,
    this.isDisabled = false,
    this.value,
    super.key,
  })  : borderWidth = borderWidth ?? 1.4,
        duration = duration ?? const Duration(milliseconds: 200),
        buttonPalette = buttonPalette ?? ButtonPalette.orange(),
        buttonStrokeBorderRadius =
            buttonStrokeBorderRadius ?? BorderRadius.circular(8),
        buttonBackgroundAndForegroundBorderRadius =
            buttonBackgroundAndForegroundBorderRadius ??
                BorderRadius.circular(6),
        buttonOnPressedShadowBorderRadius =
            buttonOnPressedShadowBorderRadius ?? BorderRadius.circular(6),
        showForegroundInnerShadow = showForegroundInnerShadow ?? false,
        borderColor = borderColor ?? Colors.black,
        isShadowDisabled = isShadowDisabled ?? false,
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
  final bool disableSound;
  final bool isDisabled;
  final Color borderColor;
  final bool? disableOnPressedForegroundColor;
  final bool? isShadowDisabled;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isPressed = useState(false);

    if (value != null) {
      isPressed.value = value!;
    }

    Future<void> playClick() async {
      if (!disableSound) {
        await SoundManager.instance.playClick();
      }
    }

    return GestureDetector(
      onTap: () async {
        if (isDisabled) return;

        await playClick();

        if (isSticky) {
          isPressed.value = !isPressed.value;

          if (isPressed.value) {
            onPressed.call();
          }
        } else {
          onPressed.call();

          isPressed.value = true;
          await Future.delayed(Durations.short1);
          isPressed.value = false;
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
          Positioned.fill(
            child: AnimatedContainer(
              curve: Curves.fastEaseInToSlowEaseOut,
              margin: EdgeInsets.only(top: isPressed.value ? 2 : 0),
              duration: duration,
              decoration: BoxDecoration(
                boxShadow: !isPressed.value && !(isShadowDisabled ?? false)
                    ? [
                        BoxShadow(
                          offset: const Offset(0, 2),
                          color: Colors.black.withValues(alpha: 0.3),
                        )
                      ]
                    : null,
                borderRadius: buttonStrokeBorderRadius,
                border: Border.all(width: borderWidth, color: borderColor),
              ),
              child: AnimatedContainer(
                duration: duration,
                margin: EdgeInsets.only(
                  top: isPressed.value ? borderWidth + 2 : borderWidth,
                ),
                decoration: BoxDecoration(
                  borderRadius:
                      buttonBackgroundAndForegroundBorderRadius,
                  color: _getButtonBackgroundColor(buttonPalette),
                ),
              ),
            ),
          ),
          AnimatedContainer(
            duration: duration,
            margin: EdgeInsets.only(
              left: borderWidth,
              right: borderWidth,
              bottom: isPressed.value ? borderWidth : borderWidth + 2,
              top: isPressed.value ? borderWidth + 2 : borderWidth,
            ),
            decoration: BoxDecoration(
              borderRadius:
                  buttonBackgroundAndForegroundBorderRadius,
              color: _getButtonForegroundColor(buttonPalette),
            ),
            child: AnimatedContainer(
              margin: EdgeInsets.all(borderWidth + 2),
              duration: duration,
              decoration: BoxDecoration(
                borderRadius: buttonOnPressedShadowBorderRadius,
                color: (isPressed.value || showForegroundInnerShadow) &&
                        !disableOnPressedForegroundColor!
                    ? Colors.black.withValues(alpha: 0.2)
                    : Colors.transparent,
              ),
              child: Center(child: child),
            ),
          ),
        ],
      ),
    );
  }
}