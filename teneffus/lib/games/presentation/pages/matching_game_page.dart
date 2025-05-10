import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flip_card/flutter_flip_card.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fpdart/fpdart.dart' as fpdart;
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:teneffus/auth/presentation/auth_notifier.dart';
import 'package:teneffus/games/domain/entities/word_card.dart';
import 'package:teneffus/games/presentation/widgets/animated_score_text.dart';
import 'package:teneffus/games/presentation/widgets/show_game_over_dialog.dart';
import 'package:teneffus/gen/assets.gen.dart';
import 'package:teneffus/global_entities/lesson.dart';
import 'package:teneffus/global_entities/unit.dart';
import 'package:teneffus/global_widgets/custom_scaffold.dart';

/// [MatchingGamePage], is the "Eşleştirme" game page.

class MatchingGamePage extends HookConsumerWidget {
  const MatchingGamePage({
    required this.selectedLessons,
    required this.selectedUnit,
    required this.selectedUnitNumber,
    this.isAllLessonsSelected = false,
    super.key,
  });

  final bool isAllLessonsSelected;
  final Unit selectedUnit;
  final int selectedUnitNumber;
  final List<Lesson> selectedLessons;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final allWords =
        selectedLessons.expand((lesson) => lesson.words).take(8).toList();

    final allFlipCards = useMemoized(() {
      final trWordCards =
          allWords.map((word) => {'id': word.id, 'value': word.tr}).toList();
      final arWordCards =
          allWords.map((word) => {'id': word.id, 'value': word.ar}).toList();

      trWordCards.shuffle(Random());
      arWordCards.shuffle(Random());

      final allCards = [...trWordCards, ...arWordCards]..shuffle(Random());

      return allCards
          .mapWithIndex((card, index) => WordCard(
              word: card["value"]!,
              controller: FlipCardController(),
              id: card["id"]!,
              index: index))
          .toList();
    });

    final flippedCardIndexes = useState(<int>[]);
    final matchedCardIndexes = useState(<int>[]);

    final score = useState(0);

    return CustomScaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          "Eşleştirme",
          style: GoogleFonts.montserrat(
              color: Colors.white, fontSize: 24, fontWeight: FontWeight.w800),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.chevron_left_rounded,
            size: 30,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "${selectedUnit.number}. Ünite ${selectedUnit.nameTr}",
                  style: const TextStyle(fontSize: 16),
                ),
                if (isAllLessonsSelected) ...[
                  const Text(
                    "Tüm Konular",
                    style: TextStyle(fontSize: 14),
                  ),
                ] else ...[
                  Text(
                    selectedLessons[0].nameTr,
                    style: const TextStyle(fontSize: 14),
                  ),
                ],
                const Gap(16),
                AnimatedScoreText(score: score),
                Expanded(
                  child: Center(
                    child: GridView.builder(
                      itemCount: allFlipCards.length,
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        mainAxisSpacing: 8,
                        crossAxisSpacing: 8,
                        childAspectRatio: 0.75,
                      ),
                      itemBuilder: (context, index) {
                        final word = allFlipCards[index].word;
                        final controller = allFlipCards[index].controller;
                        final idx = allFlipCards[index].index;
                        return InkWell(
                          onTap: () async {
                            if (matchedCardIndexes.value.contains(idx) ||
                                flippedCardIndexes.value.contains(idx)) {
                              return;
                            }

                            if (flippedCardIndexes.value.length < 2 &&
                                !flippedCardIndexes.value.contains(idx)) {
                              flippedCardIndexes.value.add(idx);
                              await controller.flipcard();
                            }

                            if (flippedCardIndexes.value.length == 2) {
                              int firstIndex = flippedCardIndexes.value[0];
                              int secondIndex = flippedCardIndexes.value[1];
                              if (allFlipCards[firstIndex].id.compareTo(
                                      allFlipCards[secondIndex].id) ==
                                  0) {
                                score.value += 10;
                                matchedCardIndexes.value
                                    .add(flippedCardIndexes.value[0]);
                                matchedCardIndexes.value
                                    .add(flippedCardIndexes.value[1]);
                                flippedCardIndexes.value.clear();
                                if (matchedCardIndexes.value.length ==
                                    allFlipCards.length) {
                                  await Future.delayed(
                                      const Duration(milliseconds: 500));

                                  await showGameOverDialog(
                                      context, score.value, ref);
                                  Navigator.pop(context);
                                }
                              } else {
                                Future.delayed(const Duration(seconds: 1),
                                    () async {
                                  allFlipCards[flippedCardIndexes.value[0]]
                                      .controller
                                      .flipcard();
                                  allFlipCards[flippedCardIndexes.value[1]]
                                      .controller
                                      .flipcard();
                                  flippedCardIndexes.value.clear();
                                  if (score.value != 0) {
                                    score.value -= 5;
                                  }
                                });
                              }
                            }
                          },
                          child: FlipCard(
                            animationDuration: Durations.short4,
                            controller: controller,
                            onTapFlipping: false,
                            rotateSide: RotateSide.left,
                            frontWidget: Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter,
                                  colors: [
                                    Color(0xFF0D47A1),
                                    Color(0xFF1565C0),
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Assets.images.appIcon.image(),
                            ),
                            backWidget: AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter,
                                  colors: [
                                    Color(0xFF0D47A1),
                                    Color(0xFF1565C0),
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              alignment: Alignment.center,
                              child: AutoSizeText(
                                word,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

int calculateStars(int score) {
  return (score / 10).floor(); // 10 puana 1 yıldız
}
