import 'package:animated_widgets/animated_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:just_audio/just_audio.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:teneffus/games/normalize_arabic.dart';
import 'package:teneffus/games/presentation/play_audio.dart';
import 'package:teneffus/games/presentation/widgets/animated_score_text.dart';
import 'package:teneffus/games/presentation/widgets/custom_progress_bar.dart';
import 'package:teneffus/games/presentation/widgets/game_header.dart';
import 'package:teneffus/games/presentation/widgets/show_game_over_dialog.dart';
import 'package:teneffus/games/presentation/widgets/step_counter.dart';
import 'package:teneffus/global_entities/button_type.dart';
import 'package:teneffus/global_entities/lesson.dart';
import 'package:teneffus/global_entities/unit.dart';
import 'package:teneffus/global_widgets/custom_button.dart';
import 'package:teneffus/global_widgets/custom_circular_progress_indicator.dart';
import 'package:teneffus/global_widgets/custom_scaffold.dart';
import 'package:teneffus/global_widgets/custom_text_button.dart';

/// [SpeakingGamePage], is the "Konuşma" game page.
/// It is a game where the user reads a word and speaks it.

final speechToTextProvider = Provider<SpeechToText>((ref) {
  final speechToText = SpeechToText();
  speechToText.initialize(
    onStatus: (status) {
      ref.read(isListeningProvider.notifier).state = status == 'listening';
    },
    onError: (error) {
      ref.read(isListeningProvider.notifier).state = false;
    },
  );
  return speechToText;
});

final isListeningProvider = StateProvider<bool>((ref) {
  return false;
});

class SpeakingGamePage extends HookConsumerWidget {
  const SpeakingGamePage({
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

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const numberOfQuestions = 16;

    final shuffledWords = useMemoized(() {
      final list = selectedLessons
          .expand((lesson) => lesson.words)
          .take(numberOfQuestions)
          .toList();
      list.shuffle();
      return list;
    });

    final speakedWord = useState("");
    final score = useState(0);
    final selectedWordIndex = useState(0);
    final selectedWord = useState(shuffledWords[selectedWordIndex.value]);

    final length = isInQuiz ?? false
        ? quizLength! * numberOfQuestions
        : shuffledWords.length;
    final currentProgress = (selectedWordIndex.value +
        (isInQuiz ?? false ? quizStep! * numberOfQuestions : 0));

    double progress = currentProgress / length;

    final player = useMemoized(() => AudioPlayer());
    final sfxPlayer = useMemoized(() => AudioPlayer());

    final microphonePermissionStatus = useState<PermissionStatus?>(null);
    final speechToText = ref.read(speechToTextProvider);
    final vibrate = useState(false);
    final isListening = ref.watch(isListeningProvider);

    final isPassed = useState(false);

    void _onSpeechResult(SpeechRecognitionResult result) {
      final expected = normalizeArabic(selectedWord.value.ar);
      final spoken = normalizeArabic(result.recognizedWords);

      speakedWord.value = spoken;
      if (spoken == expected) {
        playCorrectSound(sfxPlayer);
        score.value += 10;
        if (selectedWordIndex.value + 1 < shuffledWords.length) {
          selectedWordIndex.value += 1;
          selectedWord.value = shuffledWords[selectedWordIndex.value];
          progress = (selectedWordIndex.value) / shuffledWords.length;
        } else {
          if (isInQuiz == true) {
            onFinished?.call(score.value);
          } else {
            Future.microtask(() async {
              await showGameOverDialog(context, score.value, ref);
              Navigator.pop(context);
            });
          }
        }
      } else if (spoken.isNotEmpty) {
        playWrongSound(sfxPlayer);
        vibrate.value = true;
        Future.delayed(const Duration(milliseconds: 500), () {
          vibrate.value = false;
        });
      }
    }

    Future<void> _startListening() async {
      if (microphonePermissionStatus.value?.isGranted ?? false) {
        await speechToText.listen(
          onResult: _onSpeechResult,
          localeId: 'ar',
        );
      }
    }

    useEffect(() {
      Future.microtask(() async {
        final status = await Permission.microphone.request();
        microphonePermissionStatus.value = status;
      });
      return null;
    }, []);

    return Stack(
      children: [
        CustomScaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              title: Text(
                "Konuşma",
                style: GoogleFonts.montserrat(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w800),
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
                        const Gap(8),
                        const Text("Kelimeyi oku."),
                        const Gap(8),
                        Column(
                          children: [
                            ShakeAnimatedWidget(
                              enabled: vibrate.value,
                              duration: Durations.short1,
                              shakeAngle: Rotation.deg(z: 2),
                              child: Image.asset(
                                selectedWord.value.imagePath,
                              ),
                            ),
                            const Gap(16),
                            Text(selectedWord.value.ar,
                                style: const TextStyle(fontSize: 20)),
                            const Gap(16),
                            Text(selectedWord.value.tr),
                          ],
                        ),
                        const Gap(4),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
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
                                if (isPassed.value) {
                                  return;
                                }
                                isPassed.value = true;
                                await playAudio(
                                    selectedWord.value.audioUrl, player);
                                if (selectedWordIndex.value + 1 ==
                                    shuffledWords.length) {
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
                                  await Future.delayed(
                                      const Duration(seconds: 2), () async {
                                    selectedWordIndex.value += 1;
                                    selectedWord.value =
                                        shuffledWords[selectedWordIndex.value];
                                    isPassed.value = false;
                                  });
                                }
                              },
                            ),
                            CustomButton(
                                isDisabled: isListening,
                                buttonPalette: ButtonPalette.teal(),
                                onPressed: () async => await _startListening(),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Gap(4),
                                      Text(
                                        isListening ? "Dinleniyor" : "Konuş",
                                        style: const TextStyle(
                                            fontSize: 12, color: Colors.white),
                                      ),
                                      const Gap(4),
                                      Icon(
                                        isListening
                                            ? Icons.mic_rounded
                                            : Icons.mic_none_rounded,
                                        size: 20,
                                        color: Colors.white,
                                      ),
                                    ],
                                  ),
                                )),
                          ],
                        ),
                        const Text(
                          "Daha iyi bir deneyim için bildirim sesini kısmayı deneyebilirsiniz.",
                          style: TextStyle(
                            fontSize: 8,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  )),
            )),
        if (microphonePermissionStatus.value == null) ...[
          const CustomCircularProgressIndicator()
        ] else if (microphonePermissionStatus.value!.isDenied ||
            microphonePermissionStatus.value!.isPermanentlyDenied) ...[
          _micPermissionDialog(microphonePermissionStatus)
        ],
      ],
    );
  }

  Scaffold _micPermissionDialog(
      ValueNotifier<PermissionStatus?> microphonePermissionStatus) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(105, 0, 0, 0),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color.fromARGB(221, 82, 151, 255),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: .2),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
            border: Border.all(
              color: Colors.white,
              width: 2,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text("Mikrofon iznine ihtiyaç var."),
              const Gap(12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
                child: SizedBox(
                  width: 200,
                  child: CustomTextButton(
                    fontSize: 12,
                    onPressed: () async {
                      await openAppSettings();
                      final status = await Permission.microphone.request();
                      microphonePermissionStatus.value = status;
                    },
                    text: "Ayarlar'a git",
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
