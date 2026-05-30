import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class QuizProgress {
  final int unitNumber;
  final int lessonNumber;
  final String quizId;
  final int questionIndex;
  final bool isCompleted;
  final int totalQuestions;
  final ProgressType progressType;

  QuizProgress({
    required this.unitNumber,
    required this.lessonNumber,
    required this.quizId,
    required this.questionIndex,
    required this.isCompleted,
    required this.totalQuestions,
    required this.progressType,
  });

  Map<String, dynamic> toJson() => {
    "unitNumber": unitNumber,
    "quizId": quizId,
    "questionIndex": questionIndex,
    "isCompleted": isCompleted,
    "totalQuestions": totalQuestions,
    "lessonNumber": lessonNumber,
    "progressType": progressType.toString(),
  };

  factory QuizProgress.fromJson(Map<String, dynamic> json) {
    return QuizProgress(
      unitNumber: json["unitNumber"],
      lessonNumber: json["lessonNumber"],
      quizId: json["quizId"],
      questionIndex: json["questionIndex"],
      isCompleted: json["isCompleted"],
      totalQuestions: json["totalQuestions"],
   progressType: ProgressType.values.byName(
  (json["progressType"] as String).split('.').last
),
    );
  }
}

Future<void> saveProgress(QuizProgress progress) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString("quiz_progress", jsonEncode(progress.toJson()));
}

Future<QuizProgress?> loadProgress() async {
  final prefs = await SharedPreferences.getInstance();

  final data = prefs.getString("quiz_progress");
  if (data == null) return null;

  return QuizProgress.fromJson(jsonDecode(data));
}

Future<void> clearProgress() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.remove("quiz_progress");
}

enum ProgressType {
  listening,
  sentence,
  writing,
  speaking,
  quiz
}

String getQuizTypeText(ProgressType type) {
 switch (type) {
  case ProgressType.listening:
   return "Dinleme";
  case ProgressType.sentence:
   return "Cümle Kurma";
  case ProgressType.writing:
   return "Yazma";
  case ProgressType.speaking:
   return "Konuşma";
  case ProgressType.quiz:
   return "Sınav";
 }
}