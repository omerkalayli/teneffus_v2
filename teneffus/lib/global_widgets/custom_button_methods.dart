part of 'custom_button.dart';

/// Returns the background color of the button.
Color _getButtonBackgroundColor(ButtonPalette? buttonPalette) {
  return buttonPalette?.maybeWhen(
        orElse: () => buttonBackgroundColorOrange,
        red: () => buttonBackgroundColorRed,
        green: () => buttonBackgroundColorGreen,
        white: () => buttonBackgroundColorWhite,
        blue: () => buttonBackgroundColorBlue,
        yellow: () => buttonBackgroundColorYellow,
        gray: () => buttonBackgroundColorGrey,
        custom: (_, backgroundColor) {
          return backgroundColor;
        },
      ) ??
      buttonBackgroundColorOrange;
}

/// Returns the foreground color of the button.
Color _getButtonForegroundColor(ButtonPalette? buttonPalette) {
  return buttonPalette?.maybeWhen(
          orElse: () => buttonForegroundColorOrange,
          red: () => buttonForegroundColorRed,
          green: () => buttonForegroundColorGreen,
          white: () => buttonForegroundColorWhite,
          blue: () => buttonForegroundColorBlue,
          yellow: () => buttonForegroundColorYellow,
          gray: () => buttonForegroundColorGrey,
          custom: (foregroundColor, _) {
            return foregroundColor;
          }) ??
      buttonForegroundColorOrange;
}
