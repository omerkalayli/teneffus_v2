import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:teneffus/constants.dart';
import 'package:teneffus/gen/assets.gen.dart';

class DailyNode extends StatelessWidget {
  const DailyNode({
    required this.isDone,
    required this.label,
    required this.width,
    required this.badgeValue,
    this.isLatestDay = false,
    super.key,
  });

  final int badgeValue;
  final double width;
  final bool isDone;
  final String label;
  final bool isLatestDay;

  @override
  Widget build(BuildContext context) {
    Color lineColor = isDone ? Colors.white : Colors.black;
    double badgeWidthRatio = .36;
    double badgeWidth = width * badgeWidthRatio;
    return SizedBox(
      width: width,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              label == "Pazartesi"
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
          Positioned(
            top: -10,
            right: -8,
            child: DailyNodeBadge(
                badgeWidth: badgeWidth, isDone: isDone, badgeValue: badgeValue),
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

class DailyNodeBadge extends StatelessWidget {
  const DailyNodeBadge({
    super.key,
    required this.badgeWidth,
    required this.isDone,
    required this.badgeValue,
  });

  final double badgeWidth;
  final bool isDone;
  final int badgeValue;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: badgeWidth,
      decoration: BoxDecoration(
          color: isDone ? const Color(0xff30C26D) : const Color(0xff386D4D),
          borderRadius: BorderRadius.circular(99),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(50),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ]),
      padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 1),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "+${badgeValue.toString()}",
              style: const TextStyle(
                fontSize: 10,
                color: Colors.white,
              ),
            ),
            const Gap(2),
            Padding(
              padding: const EdgeInsets.only(top: 1.0),
              child: Assets.images.yellowStar.image(),
            )
          ],
        ),
      ),
    );
  }
}
