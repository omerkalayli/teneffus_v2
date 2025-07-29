import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:just_audio/just_audio.dart';
import 'package:teneffus/constants.dart';
import 'package:teneffus/games/presentation/play_audio.dart';
import 'package:teneffus/games/presentation/widgets/animated_score_text.dart';
import 'package:teneffus/games/presentation/widgets/custom_progress_bar.dart';
import 'package:teneffus/games/presentation/widgets/game_header.dart';
import 'package:teneffus/games/presentation/widgets/show_game_over_dialog.dart';
import 'package:teneffus/games/presentation/widgets/step_counter.dart';
import 'package:teneffus/games/presentation/widgets/word_option.dart';
import 'package:teneffus/games/update_stats.dart';
import 'package:teneffus/global_entities/button_type.dart';
import 'package:teneffus/global_entities/lesson.dart';
import 'package:teneffus/global_entities/unit.dart';
import 'package:teneffus/global_entities/word.dart';
import 'package:teneffus/global_entities/word_stat.dart';
import 'package:teneffus/global_widgets/custom_button.dart';
import 'package:teneffus/global_widgets/custom_scaffold.dart';

/// [ListeningGamePage], is the "Dinleme" game page.
/// It is a game where the user listens to a word and selects the correct option from the given options.

class ListeningGamePage extends HookConsumerWidget {
  ListeningGamePage({
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
    const numberOfQuestions = 2;

    final player = ref.watch(listeningPlayerProvider);
    final sfxPlayer = ref.watch(sfxPlayerProvider);
    final shuffledWords = useMemoized(() {
      final allWords =
          selectedLessons.expand((lesson) => lesson.words).toList();
      allWords.shuffle();
      final list = allWords.take(numberOfQuestions).toList();
      return list;
    });

    final score = useState(quizScore ?? 0);
    final selectedWordIndex = useState(0);
    final selectedChoice = useState(-1);
    final isPassed = useState(false);
    bool isDone = selectedWordIndex.value == shuffledWords.length;
    if (isDone) {
      updateStat(GameType.listening, wordStats, ref);
      if (isInQuiz == true && !isPassed.value) {
        selectedWordIndex.value -= 1;
        WidgetsBinding.instance.addPostFrameCallback((_) async {
          onFinished?.call(score.value);
        });
      } else {
        selectedWordIndex.value -= 1;
        WidgetsBinding.instance.addPostFrameCallback((_) async {
          if (!isPassed.value) {
            await showGameOverDialog(context, score.value, ref);
            Navigator.pop(context);
          }
        });
      }
    }

    final selectedWord = useState(shuffledWords[selectedWordIndex.value]);

    const replayDuration = Duration(milliseconds: 500);
    const playDuration = Duration(seconds: 2);
    final options = useState<List<Word>>([]);
    final isClickable = useState(true);

    final length = isInQuiz ?? false
        ? quizLength! * numberOfQuestions
        : shuffledWords.length;

    final currentProgress = (selectedWordIndex.value +
        (isInQuiz ?? false ? quizStep! * numberOfQuestions : 0));

    double progress = currentProgress / length;

    useEffect(() {
      if (isDone) {
        return null;
      }
      selectedWord.value = shuffledWords[selectedWordIndex.value];
      final allWords =
          selectedLessons.expand((lesson) => lesson.words).toList();
      final remaining = allWords
          .where((word) => word != selectedWord.value)
          .toList()
        ..shuffle();

      final others = remaining.take(3).toList();
      final allOptions = [...others, selectedWord.value]..shuffle();

      options.value = allOptions;

      Future.delayed(Durations.medium1, () async {
        await playAudio(selectedWord.value.audioUrl, player);
        isClickable.value = true;
      });

      selectedChoice.value = -1;

      return null;
    }, [selectedWordIndex.value]);

    void onTapWordOption(int index) {
      if (options.value[index].id == selectedWord.value.id) {
        score.value += 10;
        playCorrectSound(sfxPlayer);
        updateWordStat(StatType.correct, selectedWord.value, wordStats);
      } else if (score.value != 0) {
        playWrongSound(sfxPlayer);
        updateWordStat(StatType.incorrect, selectedWord.value, wordStats);
        score.value -= 5;
      } else {
        playWrongSound(sfxPlayer);
        updateWordStat(StatType.incorrect, selectedWord.value, wordStats);
      }
      selectedChoice.value = index;
      Future.delayed(replayDuration, () async {
        await playAudio(selectedWord.value.audioUrl, player);
      });
      if (selectedWordIndex.value < numberOfQuestions) {
        Future.delayed(playDuration, () {
          selectedWordIndex.value += 1;
        });
      } else if (isInQuiz ?? false) {
        onFinished?.call(score.value);
      }
    }

    bool? isChoiceCorrect(int index) {
      return selectedChoice.value != index
          ? selectedChoice.value != -1 &&
                  options.value[index] == selectedWord.value
              ? true
              : null
          : options.value[index].id == selectedWord.value.id;
    }

    return CustomScaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.light.copyWith(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light,
        ),
        backgroundColor: Colors.transparent,
        title: Text(
          "Dinleme",
          style: GoogleFonts.montserrat(
              color: textColor, fontSize: 24, fontWeight: FontWeight.w800),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.chevron_left_rounded,
            size: 30,
            color: textColor,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  GameHeader(
                      isAllUnitsSelected: isAllUnitsSelected,
                      selectedUnit: selectedUnit,
                      isAllLessonsSelected: isAllLessonsSelected,
                      selectedLessons: selectedLessons),
                  const Gap(32),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      children: [
                        StepCounter(
                          current: currentProgress,
                          length: length,
                        ),
                        const Spacer(),
                        AnimatedScoreText(
                          score: score,
                        ),
                      ],
                    ),
                  ),
                  const Gap(32),
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: CustomProgressBar(progress: progress)),
                ],
              ),
              const Text("Duyduğun kelimeyi seç."),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        WordOption(
                            isClickable: isClickable,
                            word: options.value[0],
                            onTap: () async {
                              onTapWordOption(0);
                            },
                            isCorrect: isChoiceCorrect(0)),
                        const Gap(36),
                        WordOption(
                            isClickable: isClickable,
                            word: options.value[1],
                            onTap: () {
                              onTapWordOption(1);
                            },
                            isCorrect: isChoiceCorrect(1)),
                      ],
                    ),
                    const Gap(32),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        WordOption(
                            isClickable: isClickable,
                            word: options.value[2],
                            onTap: () {
                              onTapWordOption(2);
                            },
                            isCorrect: isChoiceCorrect(2)),
                        const Gap(36),
                        WordOption(
                            isClickable: isClickable,
                            word: options.value[3],
                            onTap: () {
                              onTapWordOption(3);
                            },
                            isCorrect: isChoiceCorrect(3)),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(bottom: 8.0, right: 16, left: 16),
                child: _getFooter(
                    selectedWord: selectedWord,
                    player: player,
                    options: options,
                    selectedChoice: selectedChoice,
                    selectedWordIndex: selectedWordIndex,
                    score: score.value,
                    numberOfQuestions: numberOfQuestions,
                    isPassed: isPassed,
                    ref: ref),
              ),
            ],
          ),
        ),
      )),
    );
  }

  Row _getFooter({
    required ValueNotifier<Word> selectedWord,
    required AudioPlayer player,
    required ValueNotifier<List<Word>> options,
    required ValueNotifier<int> selectedChoice,
    required ValueNotifier<int> selectedWordIndex,
    required ValueNotifier<bool> isPassed,
    required int score,
    required int numberOfQuestions,
    required WidgetRef ref,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: CustomButton(
            buttonPalette: ButtonPalette.gray(),
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Pas Geç",
                      style: TextStyle(color: Colors.black, fontSize: 12)),
                  Gap(4),
                  Icon(
                    Icons.double_arrow_rounded,
                    size: 20,
                  ),
                ],
              ),
            ),
            onPressed: () async {
              if (isPassed.value) {
                return;
              }
              isPassed.value = true;
              await playAudio(selectedWord.value.audioUrl, player);
              updateWordStat(StatType.passed, selectedWord.value, wordStats);

              int correctIndex = options.value
                  .indexWhere((element) => element.id == selectedWord.value.id);
              selectedChoice.value = correctIndex;
              if (selectedWordIndex.value < numberOfQuestions - 1) {
                Future.delayed(const Duration(seconds: 2), () {
                  selectedWordIndex.value += 1;
                  isPassed.value = false;
                });
              } else if (isInQuiz ?? false) {
                Future.delayed(const Duration(seconds: 2), () {
                  isPassed.value = false;
                  onFinished?.call(score);
                });
              } else {
                Future.delayed(const Duration(seconds: 2), () {
                  isPassed.value = false;
                  selectedWordIndex.value += 1;
                });
              }
            },
          ),
        ),
        const Gap(16),
        Expanded(
          child: CustomButton(
            buttonPalette: ButtonPalette.teal(),
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Tekrar Dinle",
                      style: TextStyle(color: Colors.white, fontSize: 12)),
                  Gap(4),
                  Icon(
                    Icons.replay,
                    size: 20,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
            onPressed: () async {
              await playAudio(selectedWord.value.audioUrl, player);
            },
          ),
        ),
      ],
    );
  }
}

enum StatType { correct, incorrect, passed, date, total }

enum GameType { listening, writing, speaking, sentenceMaking }
