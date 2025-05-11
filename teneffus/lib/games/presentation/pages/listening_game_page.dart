import 'package:flutter/material.dart';
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
import 'package:teneffus/games/presentation/widgets/word_option.dart';
import 'package:teneffus/global_entities/button_type.dart';
import 'package:teneffus/global_entities/lesson.dart';
import 'package:teneffus/global_entities/unit.dart';
import 'package:teneffus/global_entities/word.dart';
import 'package:teneffus/global_widgets/custom_scaffold.dart';
import 'package:teneffus/global_widgets/custom_text_button.dart';

/// [ListeningGamePage], is the "Dinleme" game page.
/// It is a game where the user listens to a word and selects the correct option from the given options.

class ListeningGamePage extends HookConsumerWidget {
  const ListeningGamePage({
    required this.selectedLessons,
    required this.selectedUnit,
    required this.selectedUnitNumber,
    this.isAllLessonsSelected = false,
    super.key,
  });

  final bool isAllLessonsSelected;
  final Unit selectedUnit;
  final int selectedUnitNumber;
  final List<Lesson> selectedLessons;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final player = useMemoized(() => AudioPlayer());
    final sfxPlayer = useMemoized(() => AudioPlayer());
    final shuffledWords = useMemoized(() {
      final list =
          selectedLessons.expand((lesson) => lesson.words).take(16).toList();
      list.shuffle();
      return list;
    });
    final score = useState(0);
    final selectedWordIndex = useState(0);
    final selectedChoice = useState(-1);

    bool isDone = selectedWordIndex.value == shuffledWords.length;
    if (isDone) {
      selectedWordIndex.value -= 1;
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        await showGameOverDialog(context, score.value, ref);
        Navigator.pop(context);
      });
    }
    final selectedWord = useState(shuffledWords[selectedWordIndex.value]);

    const replayDuration = Duration(milliseconds: 500);
    const playDuration = Duration(seconds: 2);
    final options = useState<List<Word>>([]);
    final isClickable = useState(true);

    double progress = (selectedWordIndex.value) / shuffledWords.length;

    useEffect(() {
      if (isDone) {
        return null;
      }
      selectedWord.value = shuffledWords[selectedWordIndex.value];

      final remaining = shuffledWords
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
        Future.microtask(() async {
          await sfxPlayer.stop();
          sfxPlayer.setAudioSource(AudioSource.asset(correctSoundPath));
          sfxPlayer.play();
        });
      } else if (score.value != 0) {
        Future.microtask(() async {
          await sfxPlayer.stop();
          sfxPlayer.setAudioSource(AudioSource.asset(wrongSoundPath));
          sfxPlayer.play();
        });
        score.value -= 5;
      } else {
        Future.microtask(() async {
          await sfxPlayer.stop();
          sfxPlayer.setAudioSource(AudioSource.asset(wrongSoundPath));
          sfxPlayer.play();
        });
      }
      selectedChoice.value = index;
      Future.delayed(replayDuration, () async {
        await playAudio(selectedWord.value.audioUrl, player);
      });
      Future.delayed(playDuration, () {
        selectedWordIndex.value += 1;
      });
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
        backgroundColor: Colors.transparent,
        title: Text(
          "Dinleme",
          style: GoogleFonts.montserrat(
              color: Colors.white, fontSize: 24, fontWeight: FontWeight.w800),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.chevron_left_rounded,
            size: 30,
            color: Colors.white,
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
              GameHeader(
                  selectedUnit: selectedUnit,
                  isAllLessonsSelected: isAllLessonsSelected,
                  selectedLessons: selectedLessons),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  children: [
                    Text(
                        "${selectedWordIndex.value} / ${shuffledWords.length}"),
                    const Spacer(),
                    AnimatedScoreText(
                      score: score,
                    ),
                  ],
                ),
              ),
              CustomProgressBar(progress: progress),
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
              _getFooter(selectedWord, player, options, selectedChoice,
                  selectedWordIndex)
            ],
          ),
        ),
      )),
    );
  }

  Column _getFooter(
      ValueNotifier<Word> selectedWord,
      AudioPlayer player,
      ValueNotifier<List<Word>> options,
      ValueNotifier<int> selectedChoice,
      ValueNotifier<int> selectedWordIndex) {
    return Column(
      children: [
        CustomTextButton(
            buttonPalette: ButtonPalette.orange(),
            text: "Tekrar Dinle",
            onPressed: () async {
              await playAudio(selectedWord.value.audioUrl, player);
            }),
        const Gap(16),
        CustomTextButton(
            buttonPalette: ButtonPalette.gray(),
            text: "Pas Geç",
            onPressed: () async {
              int correctIndex = options.value
                  .indexWhere((element) => element.id == selectedWord.value.id);
              await playAudio(selectedWord.value.audioUrl, player);
              selectedChoice.value = correctIndex;
              Future.delayed(const Duration(seconds: 2), () async {
                selectedWordIndex.value += 1;
              });
            }),
      ],
    );
  }
}
