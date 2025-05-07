import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:teneffus/constants.dart';
import 'package:teneffus/global_widgets/stroked_text.dart';
import 'package:teneffus/main/presentation/widgets/daily_node.dart';

//// A widget that displays the daily rewards and streaks.
/// It shows the number of stars earned for each day in the streak.
/// The widget is designed to be used in the main page of the app.

class DailyContainer extends StatelessWidget {
  const DailyContainer({
    super.key,
    required this.dayStreak,
  });

  final int dayStreak;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        color: Color(0xff977DFF),
        border: Border(
          top: BorderSide(color: Colors.white, width: 2),
          bottom: BorderSide(color: Colors.white, width: 2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          StrokedText(
            strokeWidth: 2,
            "Günlük Ödül",
            style: TextStyle(
              fontSize: 20,
              shadows: [
                Shadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
          ),
          const Text(
            "Üst üste giriş yaparak ek yıldızlar kazan.",
            style: TextStyle(fontSize: 12),
          ),
          const Gap(16),
          Center(
            child: SizedBox(
              height: 104,
              child: LayoutBuilder(
                builder: (context, constraints) {
                  const spacerWidth = 8.0;
                  const firstItemCount = 4;

                  const firstTotalSpacer = spacerWidth * (firstItemCount - 1);
                  final itemWidth = (constraints.maxWidth - firstTotalSpacer) /
                          firstItemCount +
                      4;

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 36,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: 4,
                          itemBuilder: (context, index) {
                            final itemIndex = index;
                            return DailyNode(
                              width: itemWidth,
                              isLatestDay: itemIndex + 1 == dayStreak,
                              badgeValue: dayStreakStars[itemIndex],
                              isDone: itemIndex + 1 <= dayStreak,
                              label: days[itemIndex],
                            );
                          },
                        ),
                      ),
                      const Gap(24),
                      SizedBox(
                        height: 36,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: 3,
                            itemBuilder: (context, index) {
                              final itemIndex = index + 4;
                              return DailyNode(
                                width: itemWidth,
                                isLatestDay: itemIndex + 1 == dayStreak,
                                badgeValue: dayStreakStars[itemIndex],
                                isDone: itemIndex + 1 <= dayStreak,
                                label: days[itemIndex],
                              );
                            }),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
