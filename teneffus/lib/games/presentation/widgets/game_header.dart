import 'package:flutter/material.dart';
import 'package:teneffus/global_entities/lesson.dart';
import 'package:teneffus/global_entities/unit.dart';

class GameHeader extends StatelessWidget {
  const GameHeader({
    super.key,
    required this.selectedUnit,
    required this.isAllUnitsSelected,
    required this.isAllLessonsSelected,
    required this.selectedLessons,
  });

  final Unit selectedUnit;
  final bool isAllLessonsSelected;
  final bool isAllUnitsSelected;
  final List<Lesson> selectedLessons;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (!isAllUnitsSelected) ...[
          Text(
            "${selectedUnit.number}. Ünite ${selectedUnit.nameTr}",
            style: const TextStyle(fontSize: 14),
          ),
        ] else ...[
          const Text(
            "Tüm Üniteler",
            style: TextStyle(fontSize: 14),
          ),
        ],
        const SizedBox(height: 4),
        if (isAllLessonsSelected) ...[
          const Text(
            "Tüm Konular",
            style: TextStyle(fontSize: 12),
          ),
        ] else ...[
          Text(
            selectedLessons[0].nameTr,
            style: const TextStyle(fontSize: 12),
          ),
        ],
      ],
    );
  }
}
