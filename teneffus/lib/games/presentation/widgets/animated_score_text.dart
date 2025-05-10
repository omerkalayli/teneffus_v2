import 'package:flutter/material.dart';

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
      duration: const Duration(milliseconds: 400),
      builder: (context, value, child) {
        return Text(
          "Puan: $value",
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        );
      },
    );
  }
}
