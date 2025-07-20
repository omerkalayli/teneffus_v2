import 'package:flutter/material.dart';
import 'package:teneffus/games/presentation/pages/listening_game_page.dart';
import 'package:teneffus/global_entities/word_stat.dart';
import 'package:teneffus/words/presentation/widgets/card_top_container.dart';

class WordCard extends StatelessWidget {
  const WordCard({
    super.key,
    required this.stat,
    required this.total,
  });

  final WordStat stat;
  final int total;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CardTopContainer(
                  type: StatType.correct,
                  count: stat.correctCount,
                  all: total.toDouble(),
                ),
                CardTopContainer(
                  type: StatType.total,
                  value: total.toString(),
                ),
                CardTopContainer(
                  type: StatType.date,
                  value: stat.lastStudied.toLocal().toString().split(" ")[0],
                ),
              ],
            ),
          ),
          Card(
            margin: const EdgeInsets.only(bottom: 16),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.transparent,
                border: Border.all(
                  color: Colors.black.withValues(alpha: .05),
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  Text(stat.word.tr,
                      style: const TextStyle(color: Colors.black87)),
                  const Spacer(),
                  Text(stat.word.ar,
                      style: const TextStyle(color: Colors.black87)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
