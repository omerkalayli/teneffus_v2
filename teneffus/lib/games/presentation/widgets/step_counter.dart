import 'package:flutter/material.dart';

class StepCounter extends StatelessWidget {
  const StepCounter({required this.current, required this.length, super.key});

  final int current;
  final int length;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.blue.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text("${current - 1} / $length",
          style: const TextStyle(
            fontSize: 12,
          )),
    );
  }
}
