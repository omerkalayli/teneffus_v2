import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:just_audio/just_audio.dart';
import 'package:teneffus/auth/presentation/auth_notifier.dart';
import 'package:teneffus/constants.dart';
import 'package:teneffus/games/presentation/widgets/animated_star.dart';
import 'package:teneffus/homeworks/presentation/notifiers/homeworks_notifier.dart';

Future<void> showQuizFinishedDialog(
    {required BuildContext context,
    required int score,
    required int? minScore,
    required WidgetRef ref,
    required String homeworkId,
    required bool isHomework}) async {
  final stars = (score / 10).floor();
  ref.read(authNotifierProvider.notifier).increaseStarCount(
        starCount: stars,
      );
  bool isPassed = false;
  if (score >= (minScore ?? 0)) {
    isPassed = true;
  } else {
    isPassed = false;
  }
  if (!isHomework) {
    isPassed = true;
  }

  if (isHomework && isPassed) {
    ref.read(homeworksNotifierProvider.notifier).updateHomework(
          uid:
              ref.read(authNotifierProvider.notifier).studentInformation?.uid ??
                  "",
          homeworkId: homeworkId,
          score: score,
          isCompleted: true,
        );
  }

  final confettiController =
      ConfettiController(duration: const Duration(seconds: 2));
  isPassed ? confettiController.play() : null;
  Future.delayed(const Duration(milliseconds: 500), () async {
    AudioPlayer player = AudioPlayer();
    await player.setAsset(isPassed ? gameOverSoundPath : failureSoundPath);
    await player.play();
  });
  await showDialog(
    barrierColor: Colors.black87,
    context: context,
    barrierDismissible: true,
    builder: (_) => GestureDetector(
      onTap: () {
        confettiController.stop();
        Navigator.pop(context);
      },
      child: Stack(
        children: [
          AlertDialog(
            backgroundColor: Colors.transparent,
            title:
                Center(child: Text(isPassed ? "Tebrikler!" : "Sınav Bitti!")),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(isPassed
                    ? "Sınavı tamamladınız!"
                    : "Minimum puanı geçemediniz!"),
                const SizedBox(height: 16),
                Text(
                  "Puanınız: $score",
                  style: const TextStyle(fontSize: 14),
                ),
                const Gap(16),
                if (isHomework)
                  Text(
                    "Gereken minimum puan: $minScore",
                    style: const TextStyle(fontSize: 14),
                  ),
                const Gap(16),
                isPassed
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Kazandığınız yıldızlar: ",
                            style: TextStyle(fontSize: 14),
                          ),
                          const AnimatedStar(
                            delay: Duration(milliseconds: 150),
                          ),
                          Text(
                            "x ${stars.toString()}",
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      )
                    : const SizedBox(),
              ],
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: ConfettiWidget(
              confettiController: confettiController,
              blastDirection: pi / 2,
              blastDirectionality: BlastDirectionality.explosive,
              emissionFrequency: 0.05,
              numberOfParticles: 20,
              maxBlastForce: 20,
              minBlastForce: 1,
              gravity: 0.2,
              colors: const [
                Colors.red,
                Colors.blue,
                Colors.green,
                Colors.yellow,
              ],
              createParticlePath: (_) => drawStarPath(4),
              shouldLoop: false,
            ),
          ),
        ],
      ),
    ),
  );

  confettiController.dispose();
}

Path drawStarPath(double radius) {
  const int points = 5;
  final path = Path();
  const double angle = (2 * pi) / points;

  for (int i = 0; i < points; i++) {
    final double x = radius * cos(i * angle);
    final double y = radius * sin(i * angle);
    if (i == 0) {
      path.moveTo(x, y);
    } else {
      path.lineTo(x, y);
    }
  }
  path.close();
  return path;
}
