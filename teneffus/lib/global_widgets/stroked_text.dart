import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

/// [StrokedText], is a text widget with a stroke effect.
/// The text is displayed twice, one with a stroke and one without.
/// The stroke width and color can be customized.
///
/// Parameters:
/// - [text]: The text to be displayed.
/// - [strokeWidth]: The width of the stroke.
/// - [strokeColor]: The color of the stroke. The default value is black.
/// - [style]: The style of the text. The default value is null.
/// - [maxLines]: The maximum number of lines to be displayed. The default value is 2.

class StrokedText extends StatelessWidget {
  const StrokedText(this.text,
      {required this.strokeWidth,
      this.strokeColor = Colors.black,
      this.style,
      int? maxLines,
      super.key})
      : maxLines = maxLines ?? 2;

  final double strokeWidth;
  final TextStyle? style;
  final String text;
  final Color strokeColor;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AutoSizeText(
          text,
          minFontSize: 8,
          maxLines: 2,
          style: (style ?? const TextStyle()).copyWith(
            foreground: Paint()
              ..style = PaintingStyle.stroke
              ..strokeWidth = strokeWidth
              ..color = strokeColor,
          ),
        ),
        AutoSizeText(
          minFontSize: 8,
          text,
          maxLines: maxLines,
          style: style,
        ),
      ],
    );
  }
}
