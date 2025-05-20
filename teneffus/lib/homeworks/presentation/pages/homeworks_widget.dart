import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:teneffus/arabic/getter/getter.dart';
import 'package:teneffus/games/presentation/widgets/custom_dropdown.dart';
import 'package:teneffus/homeworks/presentation/widgets/homework_card.dart';
import 'package:teneffus/homeworks/presentation/widgets/homework_card_header.dart';
import 'package:teneffus/quiz/presentation/quiz_page.dart';

class HomeworksWidget extends StatelessWidget {
  const HomeworksWidget({
    super.key,
    required this.dropdownItems,
    required this.selectedDropdownIndex,
    required this.showEarliestFirst,
    required this.filteredHomeworks,
  });

  final List<String> dropdownItems;
  final ValueNotifier<int> selectedDropdownIndex;
  final ValueNotifier<bool> showEarliestFirst;
  final List filteredHomeworks;

  @override
  Widget build(BuildContext context) {
    return Column(
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
            child: filteredHomeworks.isEmpty
                ? const Center(
                    child: Text("Hiç göreviniz yok."),
                  )
                : Column(children: <Widget>[
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
                      final id = homework.id;
                      final units = UnitGetter.getUnits(grade);
                      final lesson = units[unitId].lessons[lessonId - 1];

                      final formattedDate =
                          DateFormat("d MMMM y", "tr_TR").format(dueDate);
                      return InkWell(
                        overlayColor:
                            const WidgetStatePropertyAll(Colors.transparent),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => QuizPage(
                                homeworkId: id,
                                isHomework: true,
                                minScore: minScore,
                                selectedUnit: units[unitId],
                                selectedLesson: lesson,
                                isAllLessonsSelected: false,
                                isAllUnitsSelected: false,
                              ),
                            ),
                          );
                        },
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
    );
  }
}
