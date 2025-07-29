import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:teneffus/arabic/getter/getter.dart';
import 'package:teneffus/auth/presentation/auth_notifier.dart';
import 'package:teneffus/constants.dart';
import 'package:teneffus/games/presentation/widgets/custom_dropdown.dart';
import 'package:teneffus/games/presentation/widgets/lesson_selection_container.dart';
import 'package:teneffus/games/presentation/widgets/unit_selection_bar.dart';
import 'package:teneffus/gen/assets.gen.dart';
import 'package:teneffus/global_entities/lesson.dart';
import 'package:teneffus/global_entities/unit.dart';
import 'package:teneffus/global_entities/word.dart';
import 'package:teneffus/global_entities/word_stat.dart';
import 'package:teneffus/students/presentation/students_notifier.dart';
import 'package:teneffus/words/presentation/widgets/word_card.dart';

class WordsPage extends HookConsumerWidget {
  const WordsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = FirebaseAuth.instance;
    final isLoading = useState(true);
    final stats = useState<List<WordStat>>([]);
    final allStats = useState<List<WordStat>>([]);
    final user = ref.watch(authNotifierProvider.notifier).studentInformation;
    final grade = user?.grade;
    final units = UnitGetter.getUnits(grade!);
    final selectedUnitNumber = useState(0);
    final lessons = units[selectedUnitNumber.value].lessons;
    final sortTypeIndex = useState(0);
    final sortIncreasing = useState(true);
    final selectedLesson = useState(0);
    final isAllLessonsSelected = useState(true);

    void _sortStats(
        ValueNotifier<List<WordStat>> stats, int sortIndex, bool increasing) {
      stats.value = [...stats.value];
      stats.value.sort((a, b) {
        int compare;
        switch (sortIndex) {
          case 0:
            final aRatio = a.correctCount /
                (a.correctCount + a.incorrectCount + a.passedCount);
            final bRatio = b.correctCount /
                (b.correctCount + b.incorrectCount + b.passedCount);
            compare = aRatio.compareTo(bRatio);
            break;
          case 1:
            compare = a.lastStudied.compareTo(b.lastStudied);
            break;
          case 2:
            compare = (a.correctCount + a.incorrectCount + a.passedCount)
                .compareTo(b.correctCount + b.incorrectCount + b.passedCount);
            break;
          default:
            compare = 0;
        }
        return increasing ? compare : -compare;
      });
    }

    int? getWordLessonNumber(List<Lesson> lessons, Word word) {
      for (final lesson in lessons) {
        for (final w in lesson.words) {
          if (w.tr == word.tr) return lesson.number;
        }
        for (final sentence in lesson.sentences ?? []) {
          for (final w in sentence.words) {
            if (w.tr == word.tr) return lesson.number;
          }
        }
      }
      return -1;
    }

    final scrollController = useScrollController();
    final scrollOffset = useState(0.0);

    useEffect(() {
      void listener() {
        scrollOffset.value = scrollController.offset;
      }

      scrollController.addListener(listener);

      return () => scrollController.removeListener(listener);
    }, [scrollController]);
    useEffect(() {
      Future.microtask(() async {
        isLoading.value = true;
        final result = await ref
            .read(studentsNotifierProvider.notifier)
            .getWordStats(auth.currentUser?.email ?? "");
        stats.value = result ?? [];
        allStats.value = stats.value;
        _sortStats(stats, sortTypeIndex.value, sortIncreasing.value);
        isLoading.value = false;
      });
      return null;
    }, []);

    useEffect(() {
      _sortStats(stats, sortTypeIndex.value, sortIncreasing.value);
      return null;
    }, [sortTypeIndex.value, sortIncreasing.value]);

    useEffect(() {
      stats.value = allStats.value.where((stat) {
        final lessonNumber = getWordLessonNumber(lessons, stat.word);
        if (isAllLessonsSelected.value) return lessonNumber != -1;
        return lessonNumber == selectedLesson.value;
      }).toList();
      return;
    }, [
      selectedUnitNumber.value,
      selectedLesson.value,
      isAllLessonsSelected.value
    ]);

    double percentScrolled;

    if (scrollOffset.value <= 150) {
      percentScrolled = 0.0;
    } else if (scrollOffset.value > 150 && scrollOffset.value <= 200) {
      percentScrolled = ((scrollOffset.value - 150) / 50).clamp(0.0, 1.0);
    } else {
      percentScrolled = 1.0;
    }
    final hasJumpedInNotification = useState(false);

    return NotificationListener(
      onNotification: (notification) {
        if (notification is ScrollEndNotification &&
            !hasJumpedInNotification.value) {
          hasJumpedInNotification.value = true;

          Future.microtask(() {
            final offset = scrollController.offset;

            if (offset > 160 && offset < 360) {
              scrollController.animateTo(
                400,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            } else if (offset < 160) {
              scrollController.animateTo(
                0,
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeInOut,
              );
            }
          });
        } else if (notification is ScrollUpdateNotification) {
          hasJumpedInNotification.value = false;
        }

        return false;
      },
      child: CustomScrollView(
        controller: scrollController,
        slivers: [
          _appBar(
              percentScrolled,
              scrollController,
              units,
              selectedUnitNumber,
              selectedLesson,
              sortTypeIndex,
              sortIncreasing,
              isAllLessonsSelected,
              lessons,
              context),
          isLoading.value
              ? SliverToBoxAdapter(
                  child: Column(
                  children: List.generate(5, (index) {
                    return Skeletonizer(
                        containersColor: Colors.white,
                        child: WordCard(stat: WordStat.empty(), total: 0));
                  }),
                ))
              : stats.value.isEmpty
                  ? SliverToBoxAdapter(
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Gap(64),
                            Assets.images.noHomework.image(
                              width: 64,
                              height: 64,
                            ),
                            const Gap(8),
                            Text(
                              "Burada kelime istatistiği yok gibi.",
                              style: GoogleFonts.montserrat(
                                  color: textColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                      ),
                    )
                  : SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          final stat = stats.value[index];
                          final total = (stat.correctCount +
                              stat.incorrectCount +
                              stat.passedCount);
                          return WordCard(stat: stat, total: total);
                        },
                        childCount: stats.value.length,
                      ),
                    ),
          const SliverToBoxAdapter(child: Gap(72)),
        ],
      ),
    );
  }

  SliverAppBar _appBar(
      double percentScrolled,
      ScrollController scrollController,
      List<Unit> units,
      ValueNotifier<int> selectedUnitNumber,
      ValueNotifier<int> selectedLesson,
      ValueNotifier<int> sortTypeIndex,
      ValueNotifier<bool> sortIncreasing,
      ValueNotifier<bool> isAllLessonsSelected,
      List<Lesson> lessons,
      BuildContext context) {
    return SliverAppBar(
      shadowColor: wordsColor.withValues(alpha: .2),
      pinned: true,
      backgroundColor: const Color(0xfff5f5f5),
      expandedHeight: 352,
      toolbarHeight: 56,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: EdgeInsets.zero,
        collapseMode: CollapseMode.pin,
        title: AnimatedContainer(
          duration: const Duration(milliseconds: 00),
          height: 56 - (1.0 - percentScrolled) * 56,
          color: const Color(0xfff5f5f5),
          child: AnimatedOpacity(
            opacity: percentScrolled,
            duration: const Duration(milliseconds: 0),
            child: Row(
              children: [
                const Gap(16),
                Text("Kelimeler",
                    style: GoogleFonts.montserrat(
                        fontSize: 18,
                        color: textColor,
                        fontWeight: FontWeight.bold)),
                const Spacer(),
                InkWell(
                  borderRadius: BorderRadius.circular(24),
                  onTap: () {
                    scrollController.animateTo(
                      0,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  },
                  child: const Icon(
                    Icons.keyboard_double_arrow_up_rounded,
                    color: textColor,
                  ),
                ),
                const Gap(16),
              ],
            ),
          ),
        ),
        background: Container(
          margin: const EdgeInsets.only(bottom: 16),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(16),
              bottomRight: Radius.circular(16),
            ),
            color: wordsColor,
          ),
          alignment: Alignment.bottomLeft,
          padding: const EdgeInsets.only(
            bottom: 4,
          ),
          child: Opacity(
            opacity: 1.0 - percentScrolled,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Gap(MediaQuery.of(context).padding.top),
                  Expanded(
                    child: Align(
                      alignment: Alignment.center,
                      child: Text("KELİMELER",
                          style: GoogleFonts.balooChettan2(
                            color: Colors.white,
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          )),
                    ),
                  ),
                  UnitSelectionBar(
                    color: wordsColor,
                    units: units,
                    selectedUnitNumber: selectedUnitNumber,
                    onTap: (i) {
                      selectedUnitNumber.value = i;
                      selectedLesson.value = 0;
                    },
                  ),
                  const Gap(16),
                  Row(
                    children: [
                      CustomDropdown(
                        baseColor: Colors.white,
                        items: const [
                          "Başarı Oranına Göre",
                          "Tarihe Göre",
                          "Toplam Sayıya Göre"
                        ],
                        selectedIndex: sortTypeIndex.value,
                        onSelected: (index) {
                          sortTypeIndex.value = index;
                        },
                        disabled: false,
                      ),
                      const Spacer(),
                      InkWell(
                        onTap: () {
                          sortIncreasing.value = !sortIncreasing.value;
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              Text(
                                sortIncreasing.value ? "Artan" : "Azalan",
                                style: const TextStyle(
                                    color: wordsColor, fontSize: 12),
                              ),
                              const Gap(2),
                              Icon(
                                sortIncreasing.value
                                    ? Icons.arrow_upward_rounded
                                    : Icons.arrow_downward_rounded,
                                color: wordsColor,
                                size: 16,
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  const Gap(8),
                  LessonSelectionContainer(
                    color: wordsColor,
                    isAllLessonsSelected: isAllLessonsSelected,
                    lessons: lessons,
                    selectedLesson: selectedLesson,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
