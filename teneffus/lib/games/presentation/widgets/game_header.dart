import 'package:flutter/material.dart';
import 'package:teneffus/global_entities/lesson.dart';
import 'package:teneffus/global_entities/unit.dart';

class GameHeader extends StatelessWidget {
  const GameHeader({
    super.key,
    required this.selectedUnit,
    required this.isAllLessonsSelected,
    required this.selectedLessons,
  });

  final Unit selectedUnit;
  final bool isAllLessonsSelected;
  final List<Lesson> selectedLessons;

  @override
  Widget build(BuildContext context) {
    return Column(
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
      ],
    );
  }
}
