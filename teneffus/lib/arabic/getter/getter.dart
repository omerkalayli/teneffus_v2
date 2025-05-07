import 'package:teneffus/global_entities/unit.dart';

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
