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
        purple: () => buttonBackgroundColorPurple,
        teal: () => buttonBackgroundColorTeal,
        darkCyan: () => buttonBackgroundColorDarkCyan,
        deepOrange: () => buttonBackgroundColorDeepOrange,
        indigo: () => buttonBackgroundColorIndigo,
        forestGreen: () => buttonBackgroundColorForestGreen,
        maroon: () => buttonBackgroundColorMaroon,
        midnightBlue: () => buttonBackgroundColorMidnightBlue,
        burntSienna: () => buttonBackgroundColorBurntSienna,
        slateGray: () => buttonBackgroundColorSlateGray,
        olive: () => buttonBackgroundColorOlive,
        darkMagenta: () => buttonBackgroundColorDarkMagenta,
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
          purple: () => buttonForegroundColorPurple,
          teal: () => buttonForegroundColorTeal,
          darkCyan: () => buttonForegroundColorDarkCyan,
          deepOrange: () => buttonForegroundColorDeepOrange,
          indigo: () => buttonForegroundColorIndigo,
          forestGreen: () => buttonForegroundColorForestGreen,
          maroon: () => buttonForegroundColorMaroon,
          midnightBlue: () => buttonForegroundColorMidnightBlue,
          burntSienna: () => buttonForegroundColorBurntSienna,
          slateGray: () => buttonForegroundColorSlateGray,
          olive: () => buttonForegroundColorOlive,
          darkMagenta: () => buttonForegroundColorDarkMagenta,
          custom: (foregroundColor, _) {
            return foregroundColor;
          }) ??
      buttonForegroundColorOrange;
}
