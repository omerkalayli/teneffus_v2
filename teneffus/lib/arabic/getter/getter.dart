import 'dart:math';

import 'package:teneffus/global_entities/unit.dart';
import 'package:teneffus/global_entities/word.dart';

import '../grades/9/grade_9.dart';

class UnitGetter {
  static List<Unit> getUnits(int grade) {
    switch (grade) {
      case 9:
        return Grade9.grade9Units;
      default:
        return [];
    }
  }
}

Word getRandomWord(List<Unit> units) {
  final random = Random();

  final allWords = <Word>[];

  for (final unit in units) {
    for (final lesson in unit.lessons) {
      allWords.addAll(lesson.words);
    }
  }

  return allWords[random.nextInt(allWords.length)];
}
