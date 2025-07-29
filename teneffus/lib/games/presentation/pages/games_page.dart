import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
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
import 'package:teneffus/global_entities/lesson.dart';
import 'package:teneffus/global_entities/unit.dart';

class GamesPage extends HookConsumerWidget {
  const GamesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedUnitNumber = useState(0);
    final selectedLesson = useState(0);
    final isAllLessonsSelected = useState(true);

    final user = ref.watch(authNotifierProvider.notifier).studentInformation;
    final grade = user?.grade;
    final units = UnitGetter.getUnits(grade!);
    final selectedUnit = units[selectedUnitNumber.value];
    final lessons = selectedUnit.lessons;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _buildSliverAppBar(
            selectedUnit: selectedUnit,
            selectedUnitNumber: selectedUnitNumber,
            selectedLesson: selectedLesson,
            units: units,
            isAllLessonsSelected: isAllLessonsSelected,
            lessons: lessons,
            context: context,
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                GameContainer(
                  backgroundColor: listeningBackgroundColor,
                  foregroundColor: listeningForegroundColor,
                  label: games.keys.elementAt(1),
                  image: games.values.elementAt(1),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ListeningGamePage(
                          isAllLessonsSelected: isAllLessonsSelected.value,
                          selectedUnit: selectedUnit,
                          selectedUnitNumber: selectedUnitNumber.value,
                          selectedLessons: isAllLessonsSelected.value
                              ? lessons
                              : [lessons[selectedLesson.value]],
                        ),
                      ),
                    );
                  },
                ),
                GameContainer(
                  backgroundColor: sentenceMakingBackgroundColor,
                  foregroundColor: sentenceMakingForegroundColor,
                  label: games.keys.elementAt(2),
                  image: games.values.elementAt(2),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => SentenceGamePage(
                          isAllLessonsSelected: isAllLessonsSelected.value,
                          selectedUnit: selectedUnit,
                          selectedUnitNumber: selectedUnitNumber.value,
                          selectedLessons: isAllLessonsSelected.value
                              ? lessons
                              : [lessons[selectedLesson.value]],
                        ),
                      ),
                    );
                  },
                ),
                GameContainer(
                  backgroundColor: writingBackgroundColor,
                  foregroundColor: writingForegroundColor,
                  label: games.keys.elementAt(3),
                  image: games.values.elementAt(3),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => WritingGamePage(
                          isAllLessonsSelected: isAllLessonsSelected.value,
                          selectedUnit: selectedUnit,
                          selectedUnitNumber: selectedUnitNumber.value,
                          selectedLessons: isAllLessonsSelected.value
                              ? lessons
                              : [lessons[selectedLesson.value]],
                        ),
                      ),
                    );
                  },
                ),
                GameContainer(
                  backgroundColor: speakingBackgroundColor,
                  foregroundColor: speakingForegroundColor,
                  label: games.keys.elementAt(4),
                  image: games.values.elementAt(4),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => SpeakingGamePage(
                          isAllLessonsSelected: isAllLessonsSelected.value,
                          selectedUnit: selectedUnit,
                          selectedUnitNumber: selectedUnitNumber.value,
                          selectedLessons: isAllLessonsSelected.value
                              ? lessons
                              : [lessons[selectedLesson.value]],
                        ),
                      ),
                    );
                  },
                ),
                GameContainer(
                  backgroundColor: matchingBackgroundColor,
                  foregroundColor: matchingForegroundColor,
                  label: games.keys.elementAt(0),
                  image: games.values.elementAt(0),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => MatchingGamePage(
                          isAllLessonsSelected: isAllLessonsSelected.value,
                          selectedUnit: selectedUnit,
                          selectedUnitNumber: selectedUnitNumber.value,
                          selectedLessons: isAllLessonsSelected.value
                              ? lessons
                              : [lessons[selectedLesson.value]],
                        ),
                      ),
                    );
                  },
                ),
                const Gap(120),
              ]),
            ),
          )
        ],
      ),
    );
  }

  SliverAppBar _buildSliverAppBar({
    required Unit selectedUnit,
    required ValueNotifier<int> selectedUnitNumber,
    required ValueNotifier<int> selectedLesson,
    required List<Unit> units,
    required ValueNotifier<bool> isAllLessonsSelected,
    required List<Lesson> lessons,
    required BuildContext context,
  }) {
    return SliverAppBar(
      pinned: true,
      expandedHeight: 380,
      backgroundColor: const Color(0xfff5f5f5),
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsets.only(left: 16, bottom: 16),
        collapseMode: CollapseMode.pin,
        background: Container(
          alignment: Alignment.bottomLeft,
          child: Center(
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 386,
                  decoration: const BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(16),
                        bottomRight: Radius.circular(16),
                      ),
                      color: gamesColor),
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 16, bottom: 0, right: 16),
                    child: Column(
                      children: [
                        Gap(MediaQuery.of(context).padding.top),
                        Expanded(
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              "OYUNLAR",
                              style: GoogleFonts.balooChettan2(
                                color: Colors.white,
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        Text(
                          "${selectedUnit.number}. Ünite - ${selectedUnit.nameTr}",
                          style: GoogleFonts.montserrat(
                            fontSize: 12,
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const Gap(16),
                        UnitSelectionBar(
                          color: gamesColor,
                          units: units,
                          selectedUnitNumber: selectedUnitNumber,
                          onTap: (i) {
                            selectedUnitNumber.value = i;
                            selectedLesson.value = 0;
                          },
                        ),
                        const Gap(4),
                        LessonSelectionContainer(
                          color: gamesColor,
                          isAllLessonsSelected: isAllLessonsSelected,
                          lessons: lessons,
                          selectedLesson: selectedLesson,
                        ),
                        const Gap(8),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
