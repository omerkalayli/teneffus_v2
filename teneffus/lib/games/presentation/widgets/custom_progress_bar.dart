import 'package:flutter/material.dart';
import 'package:teneffus/constants.dart';

class CustomProgressBar extends StatelessWidget {
  const CustomProgressBar({
    super.key,
    required this.progress,
  });

  final double progress;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 8,
      decoration: BoxDecoration(
        color: Colors.grey.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Stack(
        children: [
          AnimatedContainer(
            duration: animationDuration,
            curve: Curves.fastOutSlowIn,
            width: (MediaQuery.of(context).size.width - 32) * progress,
            decoration: BoxDecoration(
              color: Colors.teal.withValues(alpha: 0.4),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ],
      ),
    );
  }
}
