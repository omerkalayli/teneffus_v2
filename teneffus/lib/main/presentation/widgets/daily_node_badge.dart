import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:teneffus/gen/assets.gen.dart';

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
