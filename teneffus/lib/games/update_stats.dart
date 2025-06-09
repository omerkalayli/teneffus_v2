import 'package:teneffus/games/presentation/pages/listening_game_page.dart';
import 'package:teneffus/global_entities/word.dart';
import 'package:teneffus/global_entities/word_stat.dart';

void updateWordStat(
    StatType statType, Word selectedWord, List<WordStat> wordStats) {
  bool hasWordStat =
      wordStats.any((wordStat) => wordStat.word.id == selectedWord.id);

  if (!hasWordStat) {
    wordStats.add(WordStat(
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
