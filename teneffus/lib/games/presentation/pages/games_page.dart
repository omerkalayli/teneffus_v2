import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:teneffus/arabic/getter/getter.dart';
import 'package:teneffus/auth/presentation/auth_notifier.dart';
import 'package:teneffus/constants.dart';
import 'package:teneffus/games/presentation/pages/listening_game_page.dart';
import 'package:teneffus/games/presentation/pages/matching_game_page.dart';
import 'package:teneffus/games/presentation/pages/sentence_game_page.dart';
import 'package:teneffus/games/presentation/pages/speaking_game_page.dart';
import 'package:teneffus/games/presentation/pages/writing_game_page.dart';
import 'package:teneffus/games/presentation/widgets/game_container.dart';
import 'package:teneffus/games/presentation/widgets/lesson_selection_container.dart';
import 'package:teneffus/games/presentation/widgets/unit_selection_bar.dart';

/// [GamesPage] is the main page of the games section. It contains the unit selection bar, lesson selection dropdown, and game containers.

class GamesPage extends HookConsumerWidget {
  const GamesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedUnitNumber = useState(0);
    final selectedLesson = useState(0);
    final user = ref.watch(authNotifierProvider.notifier).studentInformation;
    final grade = user?.grade;
    final units = UnitGetter.getUnits(grade!);
    final lessons = units[selectedUnitNumber.value].lessons;
    final selectedUnit = units[selectedUnitNumber.value];
    final isAllLessonsSelected = useState(true);

    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("${selectedUnit.number}. Ünite ${selectedUnit.nameTr}"),
                const Gap(16),
                UnitSelectionBar(
                  units: units,
                  selectedUnitNumber: selectedUnitNumber,
                  onTap: (i) {
                    selectedUnitNumber.value = i;
                    selectedLesson.value = 0;
                  },
                ),
                const Gap(16),
                LessonSelectionContainer(
                    isAllLessonsSelected: isAllLessonsSelected,
                    lessons: lessons,
                    selectedLesson: selectedLesson),
                const Gap(16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        GameContainer(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MatchingGamePage(
                                          isAllLessonsSelected:
                                              isAllLessonsSelected.value,
                                          selectedUnit: selectedUnit,
                                          selectedUnitNumber:
                                              selectedUnitNumber.value,
                                          selectedLessons: isAllLessonsSelected
                                                  .value
                                              ? lessons
                                              : [
                                                  lessons[selectedLesson.value],
                                                ])));
                            },
                            label: games.keys.elementAt(0),
                            image: games.values.elementAt(0)),
                        GameContainer(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ListeningGamePage(
                                          isAllLessonsSelected:
                                              isAllLessonsSelected.value,
                                          selectedUnit: selectedUnit,
                                          selectedUnitNumber:
                                              selectedUnitNumber.value,
                                          selectedLessons: isAllLessonsSelected
                                                  .value
                                              ? lessons
                                              : [
                                                  lessons[selectedLesson.value],
                                                ])));
                            },
                            label: games.keys.elementAt(1),
                            image: games.values.elementAt(1)),
                      ],
                    ),
                    Row(
                      children: [
                        GameContainer(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SentenceGamePage(
                                          isAllLessonsSelected:
                                              isAllLessonsSelected.value,
                                          selectedUnit: selectedUnit,
                                          selectedUnitNumber:
                                              selectedUnitNumber.value,
                                          selectedLessons: isAllLessonsSelected
                                                  .value
                                              ? lessons
                                              : [
                                                  lessons[selectedLesson.value],
                                                ])));
                            },
                            label: games.keys.elementAt(2),
                            image: games.values.elementAt(2)),
                        GameContainer(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => WritingGamePage(
                                          isAllLessonsSelected:
                                              isAllLessonsSelected.value,
                                          selectedUnit: selectedUnit,
                                          selectedUnitNumber:
                                              selectedUnitNumber.value,
                                          selectedLessons: isAllLessonsSelected
                                                  .value
                                              ? lessons
                                              : [
                                                  lessons[selectedLesson.value],
                                                ])));
                            },
                            label: games.keys.elementAt(3),
                            image: games.values.elementAt(3)),
                      ],
                    ),
                    Row(
                      children: [
                        GameContainer(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SpeakingGamePage(
                                          isAllLessonsSelected:
                                              isAllLessonsSelected.value,
                                          selectedUnit: selectedUnit,
                                          selectedUnitNumber:
                                              selectedUnitNumber.value,
                                          selectedLessons: isAllLessonsSelected
                                                  .value
                                              ? lessons
                                              : [
                                                  lessons[selectedLesson.value],
                                                ])));
                            },
                            label: games.keys.elementAt(4),
                            image: games.values.elementAt(4)),
                        const Spacer()
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
