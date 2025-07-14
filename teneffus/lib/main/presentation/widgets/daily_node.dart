import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:teneffus/constants.dart';
import 'package:teneffus/gen/assets.gen.dart';
import 'package:teneffus/main/presentation/widgets/daily_node_badge.dart';

class DailyNode extends StatelessWidget {
  const DailyNode({
    required this.isDone,
    required this.label,
    required this.width,
    required this.badgeValue,
    required this.isPassed,
    this.isLatestDay = false,
    super.key,
  });

  final int badgeValue;
  final double width;
  final bool isDone;
  final String label;
  final bool isLatestDay;
  final bool isPassed;

  @override
  Widget build(BuildContext context) {
    Color lineColor = isDone ? Colors.white : Colors.black;
    return SizedBox(
      width: width,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              label == "Pazartesi" || label == "Cuma"
                  ? const Gap(0)
                  : AnimatedContainer(
                      duration: animationDuration,
                      width: 8,
                      height: 4,
                      decoration: BoxDecoration(
                        color: lineColor,
                      ),
                    ),
              Expanded(
                child: AnimatedContainer(
                  duration: animationDuration,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withAlpha(50),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                    border: Border.all(
                        width: 2, color: isDone ? Colors.white : Colors.black),
                    color: isDone
                        ? const Color(0xff49D631)
                        : const Color(0xffB0E4EE),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text(
                      label,
                      style: TextStyle(
                        fontSize: 12,
                        color: isDone ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          if (true)
            Positioned(
              top: -10,
              right: -8,
              child: DailyNodeBadge(isDone: isDone, badgeValue: badgeValue),
            ),
          if (isLatestDay)
            Positioned(
                bottom: -12,
                right: -12,
                child: Assets.animations.fire.lottie(height: 32)),
        ],
      ),
    );
  }
}
