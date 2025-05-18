import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:teneffus/arabic/getter/getter.dart';
import 'package:teneffus/auth/presentation/auth_notifier.dart';
import 'package:teneffus/games/presentation/widgets/custom_dropdown.dart';
import 'package:teneffus/homeworks/presentation/notifiers/homeworks_notifier.dart';
import 'package:teneffus/homeworks/presentation/widgets/homework_card.dart';
import 'package:teneffus/homeworks/presentation/widgets/homework_card_header.dart';

class HomeworksPage extends HookConsumerWidget {
  const HomeworksPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedDropdownIndex = useState(0);
    final showEarliestFirst = useState(false);
    final homeworks = ref.watch(homeworksProvider);
    final filteredHomeworks = homeworks
        .where((hw) =>
            selectedDropdownIndex.value == 0 ||
            (selectedDropdownIndex.value == 1 && hw.isCompleted) ||
            (selectedDropdownIndex.value == 2 && !hw.isCompleted))
        .toList()
      ..sort((a, b) => showEarliestFirst.value
          ? a.dueDate.compareTo(b.dueDate)
          : b.dueDate.compareTo(a.dueDate));

    final dropdownItems = [
      "Tüm Görevler",
      "Tamamlananlar",
      "Tamamlanmayanlar",
    ];

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          actions: [
            InkWell(
              onTap: () {
                ref.read(homeworksNotifierProvider.notifier).getHomeworks(
                      uid: ref
                              .read(authNotifierProvider.notifier)
                              .userInformation
                              ?.uid ??
                          "",
                    );
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(208, 33, 149, 243),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Row(
                  children: [
                    Text(
                      "Yenile",
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                    Gap(2),
                    Icon(
                      Icons.refresh,
                      color: Colors.white,
                      size: 20,
                    ),
                  ],
                ),
              ),
            ),
            const Gap(16)
          ],
          title: Text('Görevlerim',
              style: GoogleFonts.montserrat(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20)),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomDropdown(
                      items: dropdownItems,
                      selectedIndex: selectedDropdownIndex.value,
                      onSelected: (index) {
                        selectedDropdownIndex.value = index;
                      },
                      disabled: false),
                  Row(
                    children: [
                      const Text(
                        "Önce En \nYakın Tarih",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 12),
                      ),
                      Checkbox(
                          value: showEarliestFirst.value,
                          activeColor: const Color.fromARGB(208, 33, 149, 243),
                          side: const BorderSide(color: Colors.white, width: 2),
                          onChanged: (val) {
                            showEarliestFirst.value = val ?? true;
                          })
                    ],
                  )
                ],
              ),
              const Gap(16),
              Center(
                child: Text("Kartlara tıklayarak hızlıca sınava girebilirsin.",
                    style: GoogleFonts.montserrat(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w600)),
              ),
              const Gap(20),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(children: <Widget>[
                    Center(
                      child: Text("--- ${filteredHomeworks.length} görev ---",
                          style: GoogleFonts.montserrat(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w900)),
                    ),
                    const Gap(12),
                    ...List.generate(filteredHomeworks.length, (index) {
                      final homework = filteredHomeworks[index];
                      final unitId = homework.unit - 1;
                      final lessonId = homework.lesson;
                      final grade = homework.grade;
                      final teacher = homework.teacher;
                      final dueDate = homework.dueDate;
                      final myScore = homework.myScore;
                      final minScore = homework.minScore;
                      final isCompleted = homework.isCompleted;
                      final teacherId = homework.teacherId;
                      final id = homework.id;
                      final units = UnitGetter.getUnits(grade);
                      final lesson = units[unitId].lessons[lessonId - 1];

                      final formattedDate =
                          DateFormat("d MMMM y", "tr_TR").format(dueDate);
                      return InkWell(
                        overlayColor:
                            const WidgetStatePropertyAll(Colors.transparent),
                        onTap: () {},
                        child: Column(
                          children: [
                            HomeworkCardHeader(
                                teacher: teacher,
                                formattedDate: formattedDate,
                                isCompleted: isCompleted),
                            HomeworkCard(
                                grade: grade,
                                unitId: unitId,
                                lesson: lesson,
                                myScore: myScore,
                                minScore: minScore),
                            const Gap(24),
                          ],
                        ),
                      );
                    }),
                  ]),
                ),
              ),
            ],
          ),
        ));
  }
}
