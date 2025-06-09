import 'package:teneffus/global_entities/word.dart';

class WordStat {
  final Word word;
  int correctCount;
  int incorrectCount;
  int passedCount;

  WordStat({
    required this.word,
    required this.correctCount,
    required this.incorrectCount,
    required this.passedCount,
  });

  Map<String, dynamic> toJson() {
    return {
      'word': word.toJson(),
      'correctCount': correctCount,
      'incorrectCount': incorrectCount,
      'passedCount': passedCount,
    };
  }

  factory WordStat.fromJson(Map<String, dynamic> json) {
    return WordStat(
      word: Word.fromJson(json['word']),
      correctCount: json['correctCount'] ?? 0,
      incorrectCount: json['incorrectCount'] ?? 0,
      passedCount: json['passedCount'] ?? 0,
    );
  }
}
