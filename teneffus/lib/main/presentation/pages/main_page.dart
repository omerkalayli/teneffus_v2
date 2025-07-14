import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:teneffus/arabic/getter/getter.dart';
import 'package:teneffus/auth/presentation/auth_notifier.dart';
import 'package:teneffus/games/presentation/widgets/custom_dropdown.dart';
import 'package:teneffus/global_entities/button_type.dart';
import 'package:teneffus/global_entities/unit.dart';
import 'package:teneffus/global_entities/word.dart';
import 'package:teneffus/global_widgets/custom_text_button.dart';
import 'package:teneffus/main/presentation/widgets/daily_container.dart';
import 'package:teneffus/main/presentation/widgets/daily_word_container.dart';
import 'package:teneffus/main/presentation/widgets/main_unit_button.dart';
import 'package:teneffus/main/presentation/widgets/sarfia_animation.dart';
import 'package:teneffus/main/presentation/widgets/user_badge.dart';
import 'package:teneffus/quiz/presentation/quiz_page.dart';

/// [MainPage], is the main page of the application.

class MainPage extends HookConsumerWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authNotifierProvider.notifier).studentInformation;
    final grade = user?.grade;
    final units = UnitGetter.getUnits(grade!);
    final randomWord = useMemoized(() {
      // return getRandomWord(units); TODO: Replace with actual random word logic
      return Word(tr: "Kapat! (Erkeğe)", ar: "أَغْلِقْ");
    });
    final selectedUnitNumber = useState(0);
    final selectedLessonNumber = useState(0);
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            const Gap(32),
            const SarfiaAnimation(),
            const Gap(32),
            const UserBadge(),
            DailyContainer(dayStreak: user?.dayStreak ?? 1),
            const Gap(16),
            DailyWordContainer(word: randomWord),
            const Gap(40),
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.2),
                  child: CustomTextButton(
                      buttonPalette: ButtonPalette.blue(),
                      borderWidth: 1,
                      textStyle:
                          const TextStyle(fontSize: 16, color: Colors.white),
                      text: "Quize Başla",
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => QuizPage(
                              selectedUnit: units[(selectedUnitNumber.value == 0
                                      ? 1
                                      : selectedUnitNumber.value) -
                                  1],
                              selectedLesson: units[
                                      (selectedUnitNumber.value == 0
                                              ? 1
                                              : selectedUnitNumber.value) -
                                          1]
                                  .lessons[(selectedLessonNumber.value == 0
                                      ? 2
                                      : selectedLessonNumber.value) -
                                  1],
                              isAllLessonsSelected:
                                  selectedLessonNumber.value == 0,
                              isAllUnitsSelected: selectedUnitNumber.value == 0,
                            ),
                          ),
                        );
                      }),
                ),
                Container(
                  width: 2,
                  height: 24,
                  color: Colors.black,
                ),
                MainUnitButton(
                  onTapped: () {
                    showUnitAndLessonSelectionModal(context, selectedUnitNumber,
                        selectedLessonNumber, units);
                  },
                  lessonName: selectedLessonNumber.value == 0
                      ? "Tüm Dersler"
                      : units[selectedUnitNumber.value - 1]
                          .lessons[selectedLessonNumber.value - 1]
                          .nameTr,
                  unitName: selectedUnitNumber.value == 0
                      ? "Tüm Üniteler"
                      : units[selectedUnitNumber.value - 1].nameTr,
                  unitNumber: selectedUnitNumber.value - 1,
                ),
              ],
            ),
            const Gap(64)
          ],
        ),
      ),
    );
  }

  Future<dynamic> showUnitAndLessonSelectionModal(
      BuildContext context,
      ValueNotifier<int> selectedUnitNumber,
      ValueNotifier<int> selectedLessonNumber,
      List<Unit> units) {
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        int unitIndex = selectedUnitNumber.value;
        int lessonIndex = selectedLessonNumber.value;

        return StatefulBuilder(builder: (context, setState) {
          return Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            height: 180,
            width: double.infinity,
            child: Column(
              children: [
                const Text("Ünite ve Ders Seçimi",
                    style: TextStyle(
                      fontSize: 20,
                    )),
                const Gap(24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Ünite :",
                      style: TextStyle(fontSize: 14),
                    ),
                    CustomDropdown(
                      items: ["Hepsi", ...units.map((unit) => unit.nameTr)],
                      selectedIndex: unitIndex,
                      onSelected: (val) {
                        setState(() {
                          unitIndex = val;
                          lessonIndex = 0;
                        });
                        selectedUnitNumber.value = val;
                        selectedLessonNumber.value = 0;
                      },
                      disabled: false,
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Ders :",
                      style: TextStyle(fontSize: 14),
                    ),
                    CustomDropdown(
                      items: [
                        "Hepsi",
                        if (unitIndex > 0)
                          ...units[unitIndex - 1].lessons.map((l) => l.nameTr)
                      ],
                      selectedIndex: lessonIndex,
                      onSelected: (val) {
                        setState(() {
                          lessonIndex = val;
                        });
                        selectedLessonNumber.value = val;
                      },
                      disabled: false,
                    ),
                  ],
                ),
              ],
            ),
          );
        });
      },
    );
  }
}
