class Homework {
  final String id;
  final int grade;
  final int unit;
  final int lesson;
  final int minScore;
  final int myScore;
  final DateTime dueDate;
  final bool isCompleted;
  final String teacher;
  final String teacherId;

  const Homework({
    required this.id,
    required this.myScore,
    required this.grade,
    required this.unit,
    required this.lesson,
    required this.minScore,
    required this.dueDate,
    required this.isCompleted,
    required this.teacher,
    required this.teacherId,
  });

  @override
  String toString() {
    return 'Homework(id: $id, grade: $grade, unit: $unit, lesson: $lesson, minScore: $minScore, dueDate: $dueDate, isCompleted: $isCompleted, teacher: $teacher, teacherId: $teacherId)';
  }
}
