class StudentStat {
  final int listeningCorrectCount;
  final int listeningIncorrectCount;
  final int listeningPassedCount;

  final int speakingCorrectCount;
  final int speakingIncorrectCount;
  final int speakingPassedCount;
  final int writingCorrectCount;
  final int writingIncorrectCount;
  final int writingPassedCount;
  final int sentenceMakingCorrectCount;
  final int sentenceMakingIncorrectCount;
  final int sentenceMakingPassedCount;

  StudentStat({
    required this.listeningCorrectCount,
    required this.listeningIncorrectCount,
    required this.listeningPassedCount,
    required this.speakingCorrectCount,
    required this.speakingIncorrectCount,
    required this.speakingPassedCount,
    required this.writingCorrectCount,
    required this.writingIncorrectCount,
    required this.writingPassedCount,
    required this.sentenceMakingCorrectCount,
    required this.sentenceMakingIncorrectCount,
    required this.sentenceMakingPassedCount,
  });
  Map<String, dynamic> toJson() {
    return {
      'listeningCorrectCount': listeningCorrectCount,
      'listeningIncorrectCount': listeningIncorrectCount,
      'listeningPassedCount': listeningPassedCount,
      'speakingCorrectCount': speakingCorrectCount,
      'speakingIncorrectCount': speakingIncorrectCount,
      'speakingPassedCount': speakingPassedCount,
      'writingCorrectCount': writingCorrectCount,
      'writingIncorrectCount': writingIncorrectCount,
      'writingPassedCount': writingPassedCount,
      'sentenceMakingCorrectCount': sentenceMakingCorrectCount,
      'sentenceMakingIncorrectCount': sentenceMakingIncorrectCount,
      'sentenceMakingPassedCount': sentenceMakingPassedCount,
    };
  }

  factory StudentStat.fromJson(Map<String, dynamic> json) {
    return StudentStat(
      listeningCorrectCount: json['listeningCorrectCount'] ?? 0,
      listeningIncorrectCount: json['listeningIncorrectCount'] ?? 0,
      listeningPassedCount: json['listeningPassedCount'] ?? 0,
      speakingCorrectCount: json['speakingCorrectCount'] ?? 0,
      speakingIncorrectCount: json['speakingIncorrectCount'] ?? 0,
      speakingPassedCount: json['speakingPassedCount'] ?? 0,
      writingCorrectCount: json['writingCorrectCount'] ?? 0,
      writingIncorrectCount: json['writingIncorrectCount'] ?? 0,
      writingPassedCount: json['writingPassedCount'] ?? 0,
      sentenceMakingCorrectCount: json['sentenceMakingCorrectCount'] ?? 0,
      sentenceMakingIncorrectCount: json['sentenceMakingIncorrectCount'] ?? 0,
      sentenceMakingPassedCount: json['sentenceMakingPassedCount'] ?? 0,
    );
  }

  static StudentStat empty() {
    return StudentStat(
      listeningCorrectCount: 0,
      listeningIncorrectCount: 0,
      listeningPassedCount: 0,
      speakingCorrectCount: 0,
      speakingIncorrectCount: 0,
      speakingPassedCount: 0,
      writingCorrectCount: 0,
      writingIncorrectCount: 0,
      writingPassedCount: 0,
      sentenceMakingCorrectCount: 0,
      sentenceMakingIncorrectCount: 0,
      sentenceMakingPassedCount: 0,
    );
  }
}
