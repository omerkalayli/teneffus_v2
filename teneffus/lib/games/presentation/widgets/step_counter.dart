import 'package:flutter/material.dart';
import 'package:teneffus/constants.dart';

class StepCounter extends StatelessWidget {
  const StepCounter({required this.current, required this.length, super.key});

  final int current;
  final int length;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: buttonForegroundColorTeal.withValues(alpha: 0.7),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text("$current / $length",
          style: const TextStyle(fontSize: 14, color: Colors.white)),
    );
  }
}
