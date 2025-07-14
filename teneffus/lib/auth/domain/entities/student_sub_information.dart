class StudentSubInformation {
  final String name;
  final String surname;
  final int grade;
  final String rank;
  final String? teacherUid;
  final int starCount;
  final int avatarId;
  final int dayStreak;
  final DateTime? lastLogin;

  StudentSubInformation({
    required this.name,
    required this.surname,
    required this.grade,
    required this.rank,
    required this.starCount,
    required this.teacherUid,
    this.dayStreak = 1,
    this.avatarId = 0,
    this.lastLogin,
  });
}
