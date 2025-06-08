import 'package:flutter/material.dart';
import 'package:teneffus/constants.dart';
import 'package:teneffus/global_entities/word.dart';

class WordOption extends StatelessWidget {
  const WordOption({
    super.key,
    this.isCorrect,
    required this.word,
    required this.isClickable,
    required this.onTap,
  });

  final ValueNotifier<bool> isClickable;
  final bool? isCorrect;
  final Word word;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        overlayColor: const WidgetStatePropertyAll(Colors.transparent),
        onTap: () {
          if (isClickable.value) {
            isClickable.value = false;
            onTap();
          }
        },
        child: AspectRatio(
          aspectRatio: 1,
          child: AnimatedContainer(
            duration: animationDuration,
            curve: Curves.easeInOut,
            decoration: BoxDecoration(
              border: Border.all(
                width: 4,
                color: isCorrect == null
                    ? Colors.transparent
                    : isCorrect!
                        ? Colors.green.withValues(alpha: 0.5)
                        : Colors.red.shade700,
              ),
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                isCorrect == null
                    ? const BoxShadow(
                        color: Colors.transparent,
                        blurRadius: 0,
                      )
                    : const BoxShadow(
                        color: Colors.black26,
                        blurRadius: 8,
                      ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Positioned(
                    top: 0,
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Image.asset(
                      word.imagePath,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
