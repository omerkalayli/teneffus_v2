import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:teneffus/arabic/getter/getter.dart';
import 'package:teneffus/auth/presentation/auth_notifier.dart';
import 'package:teneffus/games/presentation/pages/listening_game_page.dart';
import 'package:teneffus/games/presentation/pages/sentence_game_page.dart';
import 'package:teneffus/games/presentation/pages/speaking_game_page.dart';
import 'package:teneffus/games/presentation/pages/writing_game_page.dart';
import 'package:teneffus/global_entities/lesson.dart';
import 'package:teneffus/global_entities/unit.dart';
import 'package:teneffus/quiz/presentation/show_quiz_finished_dialog.dart';

@RoutePage()
class QuizPage extends HookConsumerWidget {
  const QuizPage({
    required this.selectedLesson,
    required this.selectedUnit,
    this.isAllLessonsSelected = false,
    this.isAllUnitsSelected = false,
    this.isHomework = false,
    this.homeworkId,
    this.minScore,
    super.key,
  })  : assert(
          !isHomework || (homeworkId != null && minScore != null),
          "homeworkId and minScore must be provided if isHomework is true",
        ),
        assert(
          isHomework || (homeworkId == null && minScore == null),
          "homeworkId and minScore must be null if isHomework is false",
        );

  final Lesson selectedLesson;
  final Unit selectedUnit;
  final bool isAllLessonsSelected;
  final bool isAllUnitsSelected;
  final bool isHomework;
  final String? homeworkId;
  final int? minScore;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authNotifierProvider.notifier).studentInformation;
    final units = UnitGetter.getUnits(user?.grade ?? 9);
    final selectedLessons = isAllLessonsSelected
        ? units
            .expand((unit) => unit.lessons)
            .where((lesson) => lesson.number == selectedLesson.number)
            .toList()
        : [selectedLesson];

    final quizPhase = useState(0);
    final totalScore = useState(0);

    switch (quizPhase.value) {
      case 0:
        return SentenceGamePage(
          isInQuiz: true,
          quizLength: 4,
          quizScore: totalScore.value,
          quizStep: 0,
          selectedLessons: selectedLessons,
          selectedUnit: selectedUnit,
          selectedUnitNumber: selectedUnit.number,
          isAllLessonsSelected: isAllLessonsSelected,
          isAllUnitsSelected: isAllUnitsSelected,
          onFinished: (score) {
            quizPhase.value = 1;
            totalScore.value = score;
          },
        );
      case 1:
        return ListeningGamePage(
          isInQuiz: true,
          quizLength: 4,
          quizScore: totalScore.value,
          quizStep: 1,
          selectedLessons: selectedLessons,
          selectedUnit: selectedUnit,
          selectedUnitNumber: selectedUnit.number,
          isAllLessonsSelected: isAllLessonsSelected,
          isAllUnitsSelected: isAllUnitsSelected,
          onFinished: (score) {
            quizPhase.value = 2;
            totalScore.value = score;
          },
        );
      case 2:
        return WritingGamePage(
          isInQuiz: true,
          quizLength: 4,
          quizScore: totalScore.value,
          quizStep: 2,
          selectedLessons: selectedLessons,
          selectedUnit: selectedUnit,
          selectedUnitNumber: selectedUnit.number,
          isAllLessonsSelected: isAllLessonsSelected,
          isAllUnitsSelected: isAllUnitsSelected,
          onFinished: (score) {
            quizPhase.value = 3;
            totalScore.value = score;
          },
        );
      case 3:
        return SpeakingGamePage(
          isInQuiz: true,
          quizLength: 4,
          quizScore: totalScore.value,
          quizStep: 3,
          selectedLessons: selectedLessons,
          selectedUnit: selectedUnit,
          selectedUnitNumber: selectedUnit.number,
          isAllLessonsSelected: isAllLessonsSelected,
          isAllUnitsSelected: isAllUnitsSelected,
          onFinished: (score) {
            Future.microtask(() async {
              await showQuizFinishedDialog(
                  homeworkId: homeworkId!,
                  context: context,
                  score: score,
                  isHomework: true,
                  ref: ref,
                  minScore: minScore);
              Navigator.pop(context);
            });
          },
        );
      default:
        return const SizedBox.shrink();
    }
  }
}
