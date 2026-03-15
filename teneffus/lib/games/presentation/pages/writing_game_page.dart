import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:teneffus/constants.dart';
import 'package:teneffus/games/normalize_arabic.dart';
import 'package:teneffus/games/presentation/pages/listening_game_page.dart';
import 'package:teneffus/games/presentation/play_audio.dart';
import 'package:teneffus/games/presentation/widgets/animated_score_text.dart';
import 'package:teneffus/games/presentation/widgets/custom_progress_bar.dart';
import 'package:teneffus/games/presentation/widgets/game_header.dart';
import 'package:teneffus/games/presentation/widgets/show_game_over_dialog.dart';
import 'package:teneffus/games/presentation/widgets/step_counter.dart';
import 'package:teneffus/games/update_stats.dart';
import 'package:teneffus/global_entities/button_type.dart';
import 'package:teneffus/global_entities/lesson.dart';
import 'package:teneffus/global_entities/unit.dart';
import 'package:teneffus/global_entities/word_stat.dart';
import 'package:teneffus/global_widgets/custom_button.dart';
import 'package:teneffus/global_widgets/custom_scaffold.dart';
import 'package:teneffus/students/presentation/students_notifier.dart';

class WritingGamePage extends HookConsumerWidget {
  WritingGamePage({
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

    final sfxPlayer = ref.watch(sfxPlayerProvider);
    final scrollController = useScrollController();
    final textController = useTextEditingController();
    final shuffledWords = useMemoized(() {
      final allWords =
          selectedLessons.expand((lesson) => lesson.words).toList();
      allWords.shuffle();
      final list = allWords.take(numberOfQuestions).toList();
      return list;
    });
    final score = useState(0);
    final selectedWordIndex = useState(0);
    final selectedWord = useState(shuffledWords[selectedWordIndex.value]);
    final length = isInQuiz ?? false
        ? quizLength! * numberOfQuestions
        : shuffledWords.length;
    final currentProgress = (selectedWordIndex.value +
        (isInQuiz ?? false ? quizStep! * numberOfQuestions : 0));

    double progress = currentProgress / length;

    final isWrong = useState(false);
    final isControlling = useState(false);

    void checkAnswer() {
      if (isControlling.value) return;
      if (isWrong.value) return;
      isControlling.value = true;
      String answer = normalizeArabic(textController.text.trim());
      String correctAnswer = normalizeArabic(selectedWord.value.ar);
      bool isCorrect = answer == correctAnswer;
      if (isCorrect) {
        updateWordStat(StatType.correct, selectedWord.value, wordStats);
        playCorrectSound(sfxPlayer);
        score.value += 10;
      } else {
        playWrongSound(sfxPlayer);
        updateWordStat(StatType.incorrect, selectedWord.value, wordStats);

        isWrong.value = true;
        textController.text = selectedWord.value.ar;
        FocusScope.of(context).unfocus();

        if (score.value > 0) {
          score.value -= 5;
        }
      }
      if (selectedWordIndex.value + 1 == shuffledWords.length) {
        if (isInQuiz == true) {
          onFinished?.call(score.value);
        } else {
          Future.microtask(() async {
            updateStat(GameType.writing, wordStats, ref);
            Future.delayed(Duration(milliseconds: isCorrect ? 0 : 3000),
                () async {
              await showGameOverDialog(context, score.value, ref);
              Navigator.pop(context);
            });
          });
        }
      } else {
        Future.delayed(const Duration(milliseconds: 3000), () {
          isWrong.value = false;
          selectedWordIndex.value++;
          selectedWord.value = shuffledWords[selectedWordIndex.value];
          textController.clear();
        });
      }
      Future.delayed(Duration(milliseconds: isCorrect ? 0 : 3000), () {
        isControlling.value = false;
      });
    }

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.light.copyWith(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light,
        ),
        backgroundColor: Colors.transparent,
        title: Text(
          "Yazma",
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
        padding: const EdgeInsets.all(24),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
            scrollController.animateTo(
              0,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOut,
            ); //
          },
          child: SingleChildScrollView(
            controller: scrollController,
            child: ConstrainedBox(
              constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height -
                      kToolbarHeight -
                      MediaQuery.of(context).padding.top),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GameHeader(
                      isAllUnitsSelected: isAllUnitsSelected,
                      selectedUnit: selectedUnit,
                      isAllLessonsSelected: isAllLessonsSelected,
                      selectedLessons: selectedLessons),
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
                  CustomProgressBar(progress: progress),
                  const Text("Resimdeki kelimeyi yaz."),
                  AnimatedContainer(
                      duration: animationDuration,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                              width: 2,
                              color: isWrong.value
                                  ? Colors.red
                                  : Colors.transparent)),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.asset(selectedWord.value.imagePath))),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 80.0),
                    child: SizedBox(
                      height: 36,
                      width: 200,
                      child: TextField(
                        onSubmitted: (_) {
                          FocusScope.of(context).unfocus();
                          scrollController.animateTo(
                            0,
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeOut,
                          );
                          checkAnswer();
                        },
                        controller: textController,
                        textDirection: TextDirection.rtl,
                        textAlign: TextAlign.center,
                        cursorColor: textColor,
                        cursorHeight: 20,
                        style: const TextStyle(
                            height: 1.0, color: textColor, fontSize: 16),
                        decoration: const InputDecoration(
                            hintText: "Kelimeyi buraya yaz",
                            hintStyle: TextStyle(
                              color: Color.fromARGB(121, 127, 127, 127),
                              fontSize: 14,
                            ),
                            isCollapsed: true,
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(141, 33, 33, 33),
                                  width: 2),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: textColor, width: 2),
                            ),
                            contentPadding:
                                EdgeInsets.only(bottom: 12, right: 4)),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 12)),
                                Icon(
                                  Icons.double_arrow_rounded,
                                  size: 20,
                                ),
                              ],
                            ),
                          ),
                          onPressed: () {
                            if (isWrong.value) return;
                            updateWordStat(
                                StatType.passed, selectedWord.value, wordStats);

                            isWrong.value = true;
                            textController.text = selectedWord.value.ar;
                            FocusScope.of(context).unfocus();
                            Future.delayed(const Duration(milliseconds: 3000),
                                () {
                              if (selectedWordIndex.value + 1 ==
                                  shuffledWords.length) {
                                updateStat(GameType.writing, wordStats, ref);
                                if (isInQuiz == true) {
                                  onFinished?.call(score.value);
                                } else {
                                  Future.microtask(() async {
                                    await showGameOverDialog(
                                        context, score.value, ref);
                                    Navigator.pop(context);
                                  });
                                }
                              } else {
                                selectedWordIndex.value++;
                                selectedWord.value =
                                    shuffledWords[selectedWordIndex.value];
                                textController.clear();
                                isWrong.value = false;
                              }
                            });
                          },
                        ),
                      ),
                      const Gap(8),
                      Expanded(
                        child: CustomButton(
                          buttonPalette: ButtonPalette.darkCyan(),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Kontrol Et",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 12)),
                              ],
                            ),
                          ),
                          onPressed: () {
                            checkAnswer();
                          },
                        ),
                      )
                    ],
                  ),
                  const Gap(80)
                ],
              ),
            ),
          ),
        ),
      )),
    );
  }
}
