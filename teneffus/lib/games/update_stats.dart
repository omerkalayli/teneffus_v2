import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:teneffus/games/presentation/pages/listening_game_page.dart';
import 'package:teneffus/global_entities/student_stat.dart';
import 'package:teneffus/global_entities/word.dart';
import 'package:teneffus/global_entities/word_stat.dart';
import 'package:teneffus/students/presentation/students_notifier.dart';
import 'package:teneffus/time.dart';

Future<void> updateWordStat(
    StatType statType, Word selectedWord, List<WordStat> wordStats) async {
  bool hasWordStat =
      wordStats.any((wordStat) => wordStat.word.id == selectedWord.id);

  if (!hasWordStat) {
    wordStats.add(WordStat(
        lastStudied: await getCurrentTime(),
        word: selectedWord,
        correctCount: statType == StatType.correct ? 1 : 0,
        incorrectCount: statType == StatType.incorrect ? 1 : 0,
        passedCount: statType == StatType.passed ? 1 : 0));
  } else {
    final wordStatIndex =
        wordStats.indexWhere((wordStat) => wordStat.word.id == selectedWord.id);
    if (statType == StatType.correct) {
      wordStats[wordStatIndex].correctCount += 1;
    } else if (statType == StatType.incorrect) {
      wordStats[wordStatIndex].incorrectCount += 1;
    } else if (statType == StatType.passed) {
      wordStats[wordStatIndex].passedCount += 1;
    }
  }
}

void updateStat(GameType gameType, List<WordStat> wordStats, WidgetRef ref) {
  ref.read(studentsNotifierProvider.notifier).updateWordStats(stats: wordStats);
  int listeningCorrectCount = 0;
  int listeningIncorrectCount = 0;
  int listeningPassedCount = 0;

  int speakingCorrectCount = 0;
  int speakingIncorrectCount = 0;
  int speakingPassedCount = 0;
  int writingCorrectCount = 0;
  int writingIncorrectCount = 0;
  int writingPassedCount = 0;
  int sentenceMakingCorrectCount = 0;
  int sentenceMakingIncorrectCount = 0;
  int sentenceMakingPassedCount = 0;
  for (final wordStat in wordStats) {
    if (gameType == GameType.listening) {
      listeningCorrectCount += wordStat.correctCount;
      listeningIncorrectCount += wordStat.incorrectCount;
      listeningPassedCount += wordStat.passedCount;
    } else if (gameType == GameType.speaking) {
      speakingCorrectCount += wordStat.correctCount;
      speakingIncorrectCount += wordStat.incorrectCount;
      speakingPassedCount += wordStat.passedCount;
    } else if (gameType == GameType.writing) {
      writingCorrectCount += wordStat.correctCount;
      writingIncorrectCount += wordStat.incorrectCount;
      writingPassedCount += wordStat.passedCount;
    } else if (gameType == GameType.sentenceMaking) {
      sentenceMakingCorrectCount += wordStat.correctCount;
      sentenceMakingIncorrectCount += wordStat.incorrectCount;
      sentenceMakingPassedCount += wordStat.passedCount;
    }
  }
  StudentStat stat = StudentStat(
      listeningCorrectCount: listeningCorrectCount,
      listeningIncorrectCount: listeningIncorrectCount,
      listeningPassedCount: listeningPassedCount,
      speakingCorrectCount: speakingCorrectCount,
      speakingIncorrectCount: speakingIncorrectCount,
      speakingPassedCount: speakingPassedCount,
      writingCorrectCount: writingCorrectCount,
      writingIncorrectCount: writingIncorrectCount,
      writingPassedCount: writingPassedCount,
      sentenceMakingCorrectCount: sentenceMakingCorrectCount,
      sentenceMakingIncorrectCount: sentenceMakingIncorrectCount,
      sentenceMakingPassedCount: sentenceMakingPassedCount);
  ref.read(studentsNotifierProvider.notifier).updateStudentStats(stats: stat);
}
