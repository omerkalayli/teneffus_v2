import 'package:teneffus/global_entities/word.dart';

class WordStat {
  final Word word;
  int correctCount;
  int incorrectCount;
  int passedCount;
  DateTime lastStudied;

  WordStat({
    required this.word,
    required this.correctCount,
    required this.incorrectCount,
    required this.passedCount,
    required this.lastStudied,
  });

  Map<String, dynamic> toJson() {
    return {
      'word': word.toJson(),
      'correctCount': correctCount,
      'incorrectCount': incorrectCount,
      'passedCount': passedCount,
      'lastStudied': lastStudied.toIso8601String(),
    };
  }

  factory WordStat.fromJson(Map<String, dynamic> json) {
    return WordStat(
      word: Word.fromJson(json['word']),
      correctCount: json['correctCount'] ?? 0,
      incorrectCount: json['incorrectCount'] ?? 0,
      passedCount: json['passedCount'] ?? 0,
      lastStudied: DateTime.parse(
          json['lastStudied'] ?? DateTime.now().toIso8601String()),
    );
  }
}
