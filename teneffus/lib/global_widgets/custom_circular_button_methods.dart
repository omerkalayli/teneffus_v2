part of 'custom_circular_button.dart';

/// Returns the foreground color of the button.
Color _getButtonForegroundColor(ButtonPalette? buttonPalette) {
  return buttonPalette?.maybeWhen(
          orElse: () => buttonForegroundColorOrange,
          red: () => buttonForegroundColorRed,
          green: () => buttonForegroundColorGreen,
          white: () => buttonForegroundColorWhite,
          blue: () => buttonForegroundColorBlue,
          custom: (foregroundColor, _) {
            return foregroundColor;
          }) ??
      buttonForegroundColorOrange;
}
