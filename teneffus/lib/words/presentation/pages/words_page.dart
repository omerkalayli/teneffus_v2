import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:teneffus/games/presentation/pages/listening_game_page.dart';
import 'package:teneffus/games/presentation/widgets/custom_dropdown.dart';
import 'package:teneffus/global_entities/word_stat.dart';
import 'package:teneffus/global_widgets/custom_circular_progress_indicator.dart';
import 'package:teneffus/global_widgets/custom_scaffold.dart';
import 'package:teneffus/students/presentation/students_notifier.dart';

class WordsPage extends HookConsumerWidget {
  const WordsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = FirebaseAuth.instance;
    final isLoading = useState(true);
    final stats = useState<List<WordStat>>([]);

    final sortTypeIndex = useState(0);
    final sortIncreasing = useState(true);

    void _sortStats(
        ValueNotifier<List<WordStat>> stats, int sortIndex, bool increasing) {
      stats.value = [...stats.value]; // trigger rebuild

      stats.value.sort((a, b) {
        int compare;
        switch (sortIndex) {
          case 0:
            compare = a.correctCount.compareTo(b.correctCount);
            break;
          case 1:
            compare = a.incorrectCount.compareTo(b.incorrectCount);
            break;
          case 2:
            compare = a.passedCount.compareTo(b.passedCount);
            break;
          default:
            compare = 0;
        }
        return increasing ? compare : -compare;
      });
    }

    useEffect(() {
      Future.microtask(() async {
        final result = await ref
            .read(studentsNotifierProvider.notifier)
            .getStudentStats(auth.currentUser?.email ?? "");

        stats.value = result ?? [];

        // İlk açılışta sıralama uygula
        _sortStats(stats, sortTypeIndex.value, sortIncreasing.value);

        isLoading.value = false;
      });
      return null;
    }, []);

    useEffect(() {
      _sortStats(stats, sortTypeIndex.value, sortIncreasing.value);
      return null;
    }, [sortTypeIndex.value, sortIncreasing.value]);

    return CustomScaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text('Kelimeler',
            style: GoogleFonts.montserrat(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            )),
        centerTitle: true,
      ),
      body: isLoading.value
          ? const Center(
              child: CustomCircularProgressIndicator(
              disableBackgroundColor: true,
            ))
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      Row(
                        children: [
                          const Text("Sırala:"),
                          const Gap(8),
                          CustomDropdown(
                              width: 160,
                              items: const [
                                "Doğruya Göre",
                                "Yanlışa Göre",
                                "Pasa Göre"
                              ],
                              selectedIndex: sortTypeIndex.value,
                              onSelected: (index) {
                                sortTypeIndex.value = index;
                              },
                              disabled: false)
                        ],
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
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              Text(
                                sortIncreasing.value ? "Artan" : "Azalan",
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 12),
                              ),
                              const Gap(2),
                              Icon(
                                  sortIncreasing.value
                                      ? Icons.arrow_upward_rounded
                                      : Icons.arrow_downward_rounded,
                                  color: Colors.white,
                                  size: 16),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const Gap(16),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 60),
                    child: ListView.builder(
                      itemCount: stats.value.length,
                      itemBuilder: (context, index) {
                        final stat = stats.value[index];
                        return Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  CardTopContainer(
                                    type: StatType.incorrect,
                                    count: stat.incorrectCount,
                                  ),
                                  CardTopContainer(
                                    type: StatType.passed,
                                    count: stat.passedCount,
                                  ),
                                  CardTopContainer(
                                    type: StatType.correct,
                                    count: stat.correctCount,
                                  ),
                                ],
                              ),
                            ),
                            Card(
                              margin: const EdgeInsets.only(
                                  left: 8, right: 8, bottom: 16),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 8),
                                child: Row(
                                  children: [
                                    Text(
                                      stat.word.tr,
                                      style: const TextStyle(
                                          color: Colors.black87),
                                    ),
                                    const Spacer(),
                                    Text(
                                      stat.word.ar,
                                      style: const TextStyle(
                                          color: Colors.black87),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}

class CardTopContainer extends StatelessWidget {
  const CardTopContainer({super.key, required this.type, required this.count});

  final StatType type;
  final int count;

  @override
  Widget build(BuildContext context) {
    final suffix = type == StatType.correct
        ? " doğru"
        : type == StatType.incorrect
            ? " yanlış"
            : " pas geçme";

    final color = type == StatType.correct
        ? Colors.green
        : type == StatType.incorrect
            ? const Color(0xffE55355)
            : const Color(0xff587E8D);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: color,
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(8), topRight: Radius.circular(8)),
      ),
      child: Text(
        "$count $suffix",
        style: const TextStyle(fontSize: 10),
      ),
    );
  }
}
