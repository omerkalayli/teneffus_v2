import 'package:flutter/material.dart';
import 'package:teneffus/constants.dart';

class AnimatedScoreText extends StatelessWidget {
  const AnimatedScoreText({
    super.key,
    required this.score,
  });

  final ValueNotifier<int> score;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<int>(
      tween: IntTween(begin: 0, end: score.value),
      duration: const Duration(milliseconds: 800),
      builder: (context, value, child) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
              color: buttonForegroundColorTeal.withValues(alpha: 0.7),
              borderRadius: BorderRadius.circular(8)),
          child: Text(
            "Puan: $value",
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        );
      },
    );
  }
}
