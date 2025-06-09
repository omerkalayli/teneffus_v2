import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:just_audio/just_audio.dart';
import 'package:teneffus/constants.dart';
import 'package:teneffus/games/presentation/pages/listening_game_page.dart';
import 'package:teneffus/games/presentation/play_audio.dart';
import 'package:teneffus/games/presentation/widgets/animated_score_text.dart';
import 'package:teneffus/games/presentation/widgets/custom_progress_bar.dart';
import 'package:teneffus/games/presentation/widgets/game_header.dart';
import 'package:teneffus/games/presentation/widgets/show_game_over_dialog.dart';
import 'package:teneffus/games/presentation/widgets/step_counter.dart';
import 'package:teneffus/games/presentation/widgets/word_drag_widget.dart';
import 'package:teneffus/games/update_stats.dart';
import 'package:teneffus/global_entities/button_type.dart';
import 'package:teneffus/global_entities/lesson.dart';
import 'package:teneffus/global_entities/sentence.dart';
import 'package:teneffus/global_entities/unit.dart';
import 'package:teneffus/global_entities/word.dart';
import 'package:teneffus/global_entities/word_stat.dart';
import 'package:teneffus/global_widgets/custom_button.dart';
import 'package:teneffus/global_widgets/custom_scaffold.dart';
import 'package:teneffus/global_widgets/custom_text_button.dart';
import 'package:teneffus/students/presentation/students_notifier.dart';

/// [SentenceGamePage], is the "Cümle Kurma" game page.
/// It is a game where the user listens to a word and selects the correct option from the given options.

class SentenceGamePage extends HookConsumerWidget {
  SentenceGamePage({
    required this.selectedLessons,
    required this.selectedUnit,
    required this.selectedUnitNumber,
    this.isAllLessonsSelected = false,
    this.isAllUnitsSelected = false,
    this.isInQuiz,
    this.quizScore,
    this.quizStep,
    this.quizLength,
    this.onFinished,
    super.key,
  });

  final bool isAllLessonsSelected;
  final bool isAllUnitsSelected;
  final Unit selectedUnit;
  final int selectedUnitNumber;
  final List<Lesson> selectedLessons;
  final bool? isInQuiz;
  final int? quizScore;
  final int? quizStep;
  final int? quizLength;
  final Function(int)? onFinished;

  List<WordStat> wordStats = [];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const numberOfQuestions = 4;

    final sfxPlayer = ref.watch(sfxPlayerProvider);
    final wordSoundPlayer = useMemoized(() => AudioPlayer());
    final isControlling = useState(false);
    final List<Sentence> shuffledSentences = useMemoized(() {
      final list = selectedLessons
          .expand((lesson) => (lesson.sentences ?? []) as List<Sentence>)
          .toList();
      list.shuffle();
      return list.take(numberOfQuestions).toList();
    });
    final score = useState(quizScore ?? 0);

    final selectedSentenceIndex = useState(0);
    bool isDone = selectedSentenceIndex.value == shuffledSentences.length;
    if (isDone) {
      ref
          .read(studentsNotifierProvider.notifier)
          .updateStudentStats(stats: wordStats);
      if (isInQuiz == true) {
        onFinished?.call(score.value);
      } else {
        selectedSentenceIndex.value -= 1;
        WidgetsBinding.instance.addPostFrameCallback((_) async {
          await showGameOverDialog(context, score.value, ref);
          Navigator.pop(context);
        });
      }
    }
    final length = isInQuiz ?? false
        ? quizLength! * numberOfQuestions
        : shuffledSentences.length;
    final currentProgress = (selectedSentenceIndex.value +
        (isInQuiz ?? false ? quizStep! * numberOfQuestions : 0));

    double progress = currentProgress / length;

    List<Word> generateWordOptions(
      Sentence current,
      List<Sentence> allSentences, {
      int extraWordCount = 4,
    }) {
      final correctWords = current.words;
      final allWords = allSentences
          .expand((s) => s.words)
          .toSet()
          .difference(correctWords.toSet())
          .toList();
      allWords.shuffle();
      final extraWords = allWords.take(extraWordCount).toList();
      final options = [...correctWords, ...extraWords]..shuffle();

      final uniqueOptions = <Word>[];
      for (var word in options) {
        if (!uniqueOptions.any((w) => w.id == word.id)) {
          uniqueOptions.add(word);
        }
      }

      return uniqueOptions;
    }

    final currentSentence = shuffledSentences[selectedSentenceIndex.value];
    final options = useMemoized(
      () => generateWordOptions(currentSentence, shuffledSentences),
      [selectedSentenceIndex.value],
    );

    final droppedWords = useState<List<Word>>([]);
    final availableWords = useState<List<Word>>(List.from(options));

    final ValueNotifier<bool?> isCorrect = useState(null);
    final ValueNotifier<bool?> isPassed = useState(null);

    final Color dragTargetColor;

    if (isCorrect.value != null) {
      dragTargetColor = isCorrect.value!
          ? Colors.lightGreenAccent.shade700
          : const Color.fromARGB(148, 255, 73, 60);
    } else if (isPassed.value != null) {
      dragTargetColor = isPassed.value!
          ? Colors.grey
          : const Color.fromARGB(111, 255, 255, 255);
    } else {
      dragTargetColor = const Color.fromARGB(111, 255, 255, 255);
    }

    return CustomScaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          "Cümle Kurma",
          style: GoogleFonts.montserrat(
              color: Colors.white, fontSize: 24, fontWeight: FontWeight.w800),
        ),
        leading: IconButton(
          icon: const Icon(Icons.chevron_left_rounded,
              size: 30, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GameHeader(
                  isAllUnitsSelected: isAllUnitsSelected,
                  selectedUnit: selectedUnit,
                  isAllLessonsSelected: isAllLessonsSelected,
                  selectedLessons: selectedLessons,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    children: [
                      StepCounter(
                        current: currentProgress,
                        length: length,
                      ),
                      const Spacer(),
                      AnimatedScoreText(score: score),
                    ],
                  ),
                ),
                CustomProgressBar(progress: progress),
                const Text("Cümlenin Arapça halini yaz."),
                Text(
                  currentSentence.tr,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.montserrat(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Stack(
                  children: [
                    AnimatedContainer(
                      duration: animationDuration,
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: dragTargetColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: isCorrect.value == true || isPassed.value == true
                          ? Text(
                              currentSentence.ar,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 24,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          : Wrap(
                              alignment: WrapAlignment.center,
                              spacing: 4,
                              runSpacing: 4,
                              children: [
                                const SizedBox(
                                  width: 0,
                                  child: WordDragWidget(
                                      text: "", isTransparent: true),
                                ),
                                for (final word in droppedWords.value)
                                  WordDragWidget(
                                    isDropped: true,
                                    text: word.ar,
                                    isTransparent: false,
                                  ),
                              ],
                            ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 120,
                  child: Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      for (final word in availableWords.value)
                        GestureDetector(
                          onTap: () {
                            if (droppedWords.value.length > 4) {
                              return;
                            }
                            if (!droppedWords.value.contains(word)) {
                              Future.microtask(() async {
                                await wordSoundPlayer
                                    .setAsset(putWordSoundPath);
                                await wordSoundPlayer.seek(Duration.zero);
                                await wordSoundPlayer.play();
                              });

                              droppedWords.value = [
                                word,
                                ...droppedWords.value,
                              ];
                              availableWords.value = [...availableWords.value]
                                ..remove(word);
                            }
                          },
                          child: WordDragWidget(
                            text: word.ar,
                            isTransparent: false,
                          ),
                        ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CustomButton(
                      buttonPalette: ButtonPalette.gray(),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: Row(
                          children: [
                            Text("Pas Geç",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 12)),
                            Icon(
                              Icons.double_arrow_rounded,
                              size: 20,
                            ),
                          ],
                        ),
                      ),
                      onPressed: () async {
                        for (Word word
                            in shuffledSentences[selectedSentenceIndex.value]
                                .words) {
                          updateWordStat(StatType.passed, word, wordStats);
                        }
                        if (isPassed.value ?? false) {
                          return;
                        }
                        isPassed.value = true;
                        await Future.delayed(const Duration(seconds: 3), () {
                          isPassed.value = null;
                        });
                        if (selectedSentenceIndex.value <
                            numberOfQuestions - 1) {
                          selectedSentenceIndex.value++;
                        } else {
                          ref
                              .read(studentsNotifierProvider.notifier)
                              .updateStudentStats(stats: wordStats);
                          if (isInQuiz == true) {
                            onFinished?.call(score.value);
                          } else {
                            WidgetsBinding.instance
                                .addPostFrameCallback((_) async {
                              await showGameOverDialog(
                                  context, score.value, ref);
                              Navigator.pop(context);
                            });
                          }
                        }
                        droppedWords.value = [];
                        if (selectedSentenceIndex.value <
                            shuffledSentences.length) {
                          availableWords.value = List.from(
                            generateWordOptions(
                              shuffledSentences[selectedSentenceIndex.value],
                              shuffledSentences,
                            ),
                          );
                        }
                      },
                    ),
                    CustomButton(
                      disableSound: true,
                      buttonPalette: ButtonPalette.teal(),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: Row(
                          children: [
                            Text("Geri Al",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 12)),
                            Gap(4),
                            Icon(
                              Icons.undo_rounded,
                              color: Colors.white,
                              size: 20,
                            ),
                          ],
                        ),
                      ),
                      onPressed: () async {
                        await Future.microtask(() async {
                          await wordSoundPlayer.stop();
                          await wordSoundPlayer.setAsset(dropWordSoundPath);
                          await wordSoundPlayer.seek(Duration.zero);
                          await wordSoundPlayer.play();
                        });
                        if (droppedWords.value.isNotEmpty) {
                          final firstWord = droppedWords.value.first;
                          droppedWords.value = [...droppedWords.value]
                            ..removeAt(0);
                          availableWords.value = [
                            ...availableWords.value,
                            firstWord
                          ];
                        }
                      },
                    ),
                  ],
                ),
                CustomTextButton(
                  buttonPalette: ButtonPalette.burntSienna(),
                  textStyle: const TextStyle(
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                  disableSound: true,
                  text: "Kontrol Et",
                  onPressed: () {
                    if (isControlling.value) {
                      return;
                    }
                    isControlling.value = true;
                    String correctID =
                        shuffledSentences[selectedSentenceIndex.value].id;
                    String userSentence =
                        droppedWords.value.reversed.map((w) => w.id).join('-');
                    String userSentenceID = userSentence.hashCode.toString();

                    if (userSentenceID == correctID) {
                      for (Word word
                          in shuffledSentences[selectedSentenceIndex.value]
                              .words) {
                        updateWordStat(StatType.correct, word, wordStats);
                      }

                      playCorrectSound(sfxPlayer);
                      isCorrect.value = true;
                      score.value += 10;
                      Future.delayed(const Duration(seconds: 2), () {
                        isCorrect.value = null;
                        if (selectedSentenceIndex.value <
                            numberOfQuestions - 1) {
                          selectedSentenceIndex.value++;
                        }
                        droppedWords.value = [];
                        if (selectedSentenceIndex.value <
                            shuffledSentences.length) {
                          availableWords.value = List.from(
                            generateWordOptions(
                              shuffledSentences[selectedSentenceIndex.value],
                              shuffledSentences,
                            ),
                          );
                        }
                      });
                    } else {
                      if (score.value > 0) score.value -= 5;
                      playWrongSound(sfxPlayer);
                      for (Word word
                          in shuffledSentences[selectedSentenceIndex.value]
                              .words) {
                        updateWordStat(StatType.incorrect, word, wordStats);
                      }
                      isCorrect.value = false;
                      Future.delayed(const Duration(seconds: 2), () {
                        isCorrect.value = null;
                      });
                    }
                    Future.delayed(const Duration(seconds: 2), () {
                      isControlling.value = false;
                    });
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
