import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:teneffus/constants.dart';
import 'package:teneffus/gen/assets.gen.dart';
import 'package:teneffus/main/presentation/widgets/daily_node_badge.dart';

//// A widget that displays the daily rewards and streaks.
/// It shows the number of stars earned for each day in the streak.
/// The widget is designed to be used in the main page of the app.

class DailyContainer extends StatefulWidget {
  const DailyContainer({
    required this.dayStreak,
    super.key,
  });

  final int dayStreak;

  @override
  State<DailyContainer> createState() => _DailyContainerState();
}

class _DailyContainerState extends State<DailyContainer> {
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.dayStreak > 0) {
        final scrollPosition = 80.0 * (widget.dayStreak - 1) - 120;
        _scrollController.animateTo(
          scrollPosition,
          duration: const Duration(milliseconds: 1000),
          curve: Curves.easeInOutExpo,
        );
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          color: Colors.transparent,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                "Günlük Ödül",
                style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                ),
              ),
            ),
            const Gap(4),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                "Üst üste giriş yaparak ek yıldızlar kazan.",
                style: GoogleFonts.montserrat(
                    color: textColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w600),
              ),
            ),
            const Gap(20),
            SizedBox(
              height: 120,
              child: ListView(
                controller: _scrollController,
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                scrollDirection: Axis.horizontal,
                children: List.generate(widget.dayStreak + 6, (index) {
                  return index == widget.dayStreak + 5
                      ? const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Center(
                              child: Text(
                            "...",
                            style: TextStyle(
                                color: Colors.black54,
                                fontSize: 20,
                                fontWeight: FontWeight.w700),
                          )),
                        )
                      : SizedBox(
                          width: 80,
                          child: Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Card(
                                shadowColor: index + 1 == widget.dayStreak
                                    ? Colors.transparent
                                    : Colors.green,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      color: index + 1 == widget.dayStreak
                                          ? Colors.green
                                          : Colors.transparent,
                                      width: 2,
                                    ),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Gün",
                                        style: GoogleFonts.montserrat(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: index < widget.dayStreak
                                              ? Colors.black
                                              : Colors.grey,
                                        ),
                                      ),
                                      Text(
                                        "${index + 1}",
                                        style: GoogleFonts.montserrat(
                                          fontSize: 24,
                                          fontWeight: FontWeight.w700,
                                          color: index < widget.dayStreak
                                              ? Colors.black
                                              : Colors.grey,
                                        ),
                                      ),
                                      const Gap(2),
                                      DailyNodeBadge(
                                        isDone: index < widget.dayStreak,
                                        badgeValue: (() {
                                          int value = pow(1.5, index).toInt();
                                          return value > 10
                                              ? (value / 10).round() * 10
                                              : value;
                                        })(),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              if (index == widget.dayStreak - 1)
                                Positioned(
                                  top: -24,
                                  child: Assets.animations.sparkle.lottie(
                                    height: 80,
                                    width: 80,
                                    repeat: true,
                                    fit: BoxFit.cover,
                                    animate: true,
                                  ),
                                ),
                            ],
                          ),
                        );
                }),
              ),
            )
          ],
        ),
      ),
    );
  }
}
