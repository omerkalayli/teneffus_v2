import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:teneffus/arabic/getter/getter.dart';

import 'package:teneffus/auth/domain/entities/student_information.dart';
import 'package:teneffus/auth/domain/entities/teacher_information.dart';
import 'package:teneffus/auth/presentation/auth_notifier.dart';
import 'package:teneffus/constants.dart';
import 'package:teneffus/games/presentation/widgets/custom_dropdown.dart';
import 'package:teneffus/gen/assets.gen.dart';
import 'package:teneffus/global_entities/lesson.dart';
import 'package:teneffus/global_entities/snackbar_type.dart';
import 'package:teneffus/global_entities/unit.dart';
import 'package:teneffus/global_widgets/custom_scaffold.dart';
import 'package:teneffus/global_widgets/custom_snackbar.dart';
import 'package:teneffus/global_widgets/student_search_bar.dart';
import 'package:teneffus/homeworks/domain/entities/homework.dart';
import 'package:teneffus/homeworks/presentation/notifiers/homeworks_notifier.dart';
import 'package:teneffus/students/presentation/students_notifier.dart';
import 'package:teneffus/time.dart';
import 'package:uuid/uuid.dart';

class HomeworkCreationPage extends HookConsumerWidget {
  const HomeworkCreationPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedGradeIndex = useState(0);
    final units = UnitGetter.getUnits(selectedGradeIndex.value + 9);
    final selectedUnitNumber = useState(0);
    final lessons = units[selectedUnitNumber.value].lessons;
    final selectedLessonNumber = useState(0);
    final minScoreTextEditingController = useTextEditingController();
    final dueDate = useState<DateTime>(DateTime.now());

    useEffect(() {
      Future<void> loadTime() async {
        dueDate.value = await getCurrentTime();
      }

      loadTime();
      return null;
    }, []);

    final teacher = ref.watch(teacherInformationProvider);
    final students = ref.watch(studentsProvider);
    final textEditingController = useTextEditingController();
    final filteredStudents = useState<List<StudentInformation>>(students);

    final selectedStudentGrade = useState(8); // 9th grade is index 0

    final selectedStudentEmails = useState<List<String>>([]);

    useEffect(() {
      textEditingController.addListener(() {
        final query = textEditingController.text.toLowerCase();
        filteredStudents.value = students
            .where((student) =>
                student.name.toLowerCase().contains(query) ||
                student.surname.toLowerCase().contains(query))
            .toList();
      });
      return null;
    }, [textEditingController.text, selectedStudentGrade.value]);

    final scrollController = useScrollController();
    final scrollOffset = useState(0.0);

    useEffect(() {
      void listener() {
        scrollOffset.value = scrollController.offset;
      }

      scrollController.addListener(listener);

      return () => scrollController.removeListener(listener);
    }, [scrollController]);

    double percentScrolled;

    if (scrollOffset.value <= 150) {
      percentScrolled = 0.0;
    } else if (scrollOffset.value > 150 && scrollOffset.value <= 200) {
      percentScrolled = ((scrollOffset.value - 150) / 50).clamp(0.0, 1.0);
    } else {
      percentScrolled = 1.0;
    }
    final hasJumpedInNotification = useState(false);
    return RefreshIndicator(
      onRefresh: () async {
        textEditingController.clear();
        final info = await ref
            .read(authNotifierProvider.notifier)
            .getTeacherInformation();
      },
      child: NotificationListener(
        onNotification: (notification) {
          if (notification is ScrollEndNotification &&
              !hasJumpedInNotification.value) {
            hasJumpedInNotification.value = true;

            Future.microtask(() {
              final offset = scrollController.offset;

              if (offset > 160 && offset < 240) {
                scrollController.animateTo(
                  220,
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
        child: CustomScaffold(
          flotingActionButton: selectedStudentEmails.value.isNotEmpty
              ? SendHomeworkButton(
                  minScoreTextEditingController: minScoreTextEditingController,
                  selectedStudentEmails: selectedStudentEmails,
                  selectedGradeIndex: selectedGradeIndex,
                  selectedUnitNumber: selectedUnitNumber,
                  selectedLessonNumber: selectedLessonNumber,
                  dueDate: dueDate,
                  teacher: teacher,
                  textEditingController: textEditingController,
                  filteredStudents: filteredStudents,
                  students: students)
              : null,
          body: CustomScrollView(
            controller: scrollController,
            slivers: [
              SliverAppBar(
                shadowColor: profileColor.withValues(alpha: .2),
                pinned: true,
                backgroundColor: const Color(0xfff5f5f5),
                expandedHeight: 340,
                toolbarHeight: 56,
                flexibleSpace: FlexibleSpaceBar(
                  titlePadding: EdgeInsets.zero,
                  collapseMode: CollapseMode.pin,
                  title: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    height: 56 - (1.0 - percentScrolled) * 56,
                    color: const Color(0xfff5f5f5),
                    child: AnimatedOpacity(
                      opacity: percentScrolled,
                      duration: const Duration(milliseconds: 300),
                      child: Row(
                        children: [
                          const Gap(16),
                          Text("Ödev Oluştur",
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
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(16),
                          bottomRight: Radius.circular(16),
                        ),
                        color: homeworksColor),
                    alignment: Alignment.bottomLeft,
                    padding: const EdgeInsets.only(
                      bottom: 4,
                    ),
                    child: Opacity(
                      opacity: 1.0 - percentScrolled,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Gap(MediaQuery.of(context).padding.top),
                            Expanded(
                              child: Align(
                                alignment: Alignment.center,
                                child: Text("ÖDEV OLUŞTUR",
                                    style: GoogleFonts.balooChettan2(
                                      color: Colors.white,
                                      fontSize: 32,
                                      fontWeight: FontWeight.bold,
                                    )),
                              ),
                            ),
                            _homeworkInfoHeader(
                                selectedGradeIndex,
                                selectedUnitNumber,
                                selectedLessonNumber,
                                units,
                                minScoreTextEditingController,
                                lessons,
                                context,
                                dueDate),
                            const Gap(8),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SliverList(
                  delegate: SliverChildListDelegate([
                const Gap(8),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
                  child: Text(
                    "Görev Atanacak Öğrenciler",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                const Gap(4),
                StudentSearchBar(
                  baseColor: textColor,
                  textEditingController: textEditingController,
                  selectedStudentGrade: selectedStudentGrade,
                  onSelectionChanged: (index) {
                    selectedStudentGrade.value =
                        index + 8; // 9th grade is index 0
                    filteredStudents.value = students.where((student) {
                      final matchesName = student.name.toLowerCase().contains(
                              textEditingController.text.toLowerCase()) ||
                          textEditingController.text.isEmpty;
                      final matchesGrade = index == 8 || student.grade == index;
                      return matchesName && matchesGrade;
                    }).toList();
                  },
                ),
                const Gap(16),
                ...studentSelection(
                  textEditingController,
                  selectedStudentGrade,
                  filteredStudents,
                  students,
                  selectedStudentEmails,
                ),
                const Gap(500)
              ])),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> studentSelection(
      TextEditingController textEditingController,
      ValueNotifier<int> selectedStudentGrade,
      ValueNotifier<List<StudentInformation>> filteredStudents,
      List<StudentInformation> students,
      ValueNotifier<List<String>> selectedStudentEmails) {
    if (filteredStudents.value.isEmpty) {
      return [
        Center(
          child: Column(
            children: [
              const Gap(16),
              Assets.images.noUser
                  .image(width: 32, height: 32, color: textColor),
              const Gap(4),
              const Text(
                "Öğrenci bulunamadı",
                style: TextStyle(color: textColor, fontSize: 14),
              ),
            ],
          ),
        )
      ];
    } else {
      return List.generate(filteredStudents.value.length, (index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: InkWell(
            overlayColor: const WidgetStatePropertyAll(Colors.transparent),
            onTap: () {
              bool value = selectedStudentEmails.value
                  .contains(filteredStudents.value[index].email);
              if (!value) {
                List<String> emails = [...selectedStudentEmails.value];
                emails.add(filteredStudents.value[index].email);
                selectedStudentEmails.value = emails;
              } else {
                List<String> emails = [...selectedStudentEmails.value];
                emails.remove(filteredStudents.value[index].email);
                selectedStudentEmails.value = emails;
              }
            },
            child: Card(
              margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 4),
              child: ListTile(
                dense: true,
                contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                title: Text(
                  "${filteredStudents.value[index].name} ${filteredStudents.value[index].surname}",
                  style: const TextStyle(color: textColor, fontSize: 14),
                ),
                subtitle: Text(
                  "${filteredStudents.value[index].grade}. Sınıf",
                  style: const TextStyle(fontSize: 12, color: textColor),
                ),
                trailing: Checkbox(
                  side: const BorderSide(color: textColor, width: 2),
                  fillColor: WidgetStatePropertyAll(selectedStudentEmails.value
                          .contains(filteredStudents.value[index].email)
                      ? homeworksColor
                      : Colors.transparent),
                  value: selectedStudentEmails.value
                      .contains(filteredStudents.value[index].email),
                  onChanged: (value) {
                    if (value == true) {
                      List<String> emails = [...selectedStudentEmails.value];
                      emails.add(filteredStudents.value[index].email);
                      selectedStudentEmails.value = emails;
                    } else {
                      List<String> emails = [...selectedStudentEmails.value];
                      emails.remove(filteredStudents.value[index].email);
                      selectedStudentEmails.value = emails;
                    }
                  },
                ),
              ),
            ),
          ),
        );
      });
    }
  }

  Widget _homeworkInfoHeader(
      ValueNotifier<int> selectedGradeIndex,
      ValueNotifier<int> selectedUnitNumber,
      ValueNotifier<int> selectedLessonNumber,
      List<Unit> units,
      TextEditingController minScoreTextEditingController,
      List<Lesson> lessons,
      BuildContext context,
      ValueNotifier<DateTime> dueDate) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 8.0, bottom: 4),
                    child: Text(
                      "Sınıf",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  CustomDropdown(
                      baseColor: Colors.white,
                      width: 120,
                      items: const [
                        "9. Sınıf",
                        "10. Sınıf",
                        "11. Sınıf",
                        "12. Sınıf"
                      ],
                      selectedIndex: selectedGradeIndex.value,
                      onSelected: (index) {
                        selectedGradeIndex.value = index;
                        selectedUnitNumber.value = 0;
                        selectedLessonNumber.value = 0;
                      },
                      disabled: false)
                ],
              ),
              const Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 8.0, bottom: 4),
                    child: Text(
                      "Ünite",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  CustomDropdown(
                      baseColor: Colors.white,
                      items: List.generate(units.length, (context) {
                        return "${units[context].number}. ${units[context].nameTr}";
                      }),
                      selectedIndex: selectedUnitNumber.value,
                      onSelected: (index) {
                        selectedUnitNumber.value = index;
                        selectedLessonNumber.value = 0;
                      },
                      disabled: false)
                ],
              )
            ],
          ),
          const Gap(8),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 8.0, bottom: 4),
                      child: Text(
                        "Geçme Notu",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                      width: 120,
                      child: TextField(
                        controller: minScoreTextEditingController,
                        cursorColor: Colors.white,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 12),
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.only(left: 8),
                          hintStyle: TextStyle(
                              color: Colors.white.withValues(alpha: .8),
                              fontSize: 12),
                          filled: true,
                          fillColor: Colors.white.withValues(alpha: 0.2),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Gap(8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 8.0, bottom: 4),
                    child: Text(
                      "Konu",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  CustomDropdown(
                      baseColor: Colors.white,
                      items: List.generate(lessons.length, (context) {
                        return "${lessons[context].number}. ${lessons[context].nameTr}";
                      }),
                      selectedIndex: selectedLessonNumber.value,
                      onSelected: (index) {
                        selectedLessonNumber.value = index;
                      },
                      disabled: false)
                ],
              ),
            ],
          ),
          const Gap(8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 8.0, bottom: 4),
                child: Text(
                  "Bitiş Tarihi",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              InkWell(
                onTap: () {
                  showDatePicker(
                    locale: const Locale("tr", "TR"),
                    context: context,
                    initialDate: dueDate.value,
                    firstDate: dueDate.value,
                    lastDate: DateTime(2100),
                    builder: (context, child) {
                      return Theme(
                        data: Theme.of(context).copyWith(
                          colorScheme: const ColorScheme.light(
                            primary: homeworksColor,
                            onPrimary: Colors.white,
                            onSurface: Colors.black,
                          ),
                          textButtonTheme: TextButtonThemeData(
                            style: TextButton.styleFrom(
                              foregroundColor: homeworksColor,
                            ),
                          ),
                        ),
                        child: child!,
                      );
                    },
                  ).then((selectedDate) {
                    if (selectedDate != null) {
                      dueDate.value = selectedDate;
                    }
                  });
                },
                child: Container(
                  width: 120,
                  height: 30,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "${dueDate.value.day}/${dueDate.value.month}/${dueDate.value.year}",
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.8),
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class SendHomeworkButton extends HookConsumerWidget {
  const SendHomeworkButton({
    super.key,
    required this.minScoreTextEditingController,
    required this.selectedStudentEmails,
    required this.selectedGradeIndex,
    required this.selectedUnitNumber,
    required this.selectedLessonNumber,
    required this.dueDate,
    required this.teacher,
    required this.textEditingController,
    required this.filteredStudents,
    required this.students,
  });

  final TextEditingController minScoreTextEditingController;
  final ValueNotifier<List<String>> selectedStudentEmails;
  final ValueNotifier<int> selectedGradeIndex;
  final ValueNotifier<int> selectedUnitNumber;
  final ValueNotifier<int> selectedLessonNumber;
  final ValueNotifier<DateTime> dueDate;
  final TeacherInformation? teacher;
  final TextEditingController textEditingController;
  final ValueNotifier<List<StudentInformation>> filteredStudents;
  final List<StudentInformation> students;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                backgroundColor: Colors.white,
                title: const Text("Görev Gönderimi"),
                content: const Text(
                    "Görevleri bu öğrencilere göndermek istediğinize emin misiniz?"),
                actions: [
                  TextButton(
                    onPressed: () async {
                      Navigator.pop(context);
                    },
                    child: Text(
                      "Hayır",
                      style: GoogleFonts.montserrat(
                          color: textColor, fontWeight: FontWeight.bold),
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      if (minScoreTextEditingController.text.isEmpty) {
                        Navigator.pop(context);
                        CustomSnackbar.show(
                            type: SnackbarType.error(),
                            message: "Geçme notu boş olamaz",
                            context: context);
                        return;
                      }
                      const uuid = Uuid();
                      final res = await ref
                          .read(homeworksNotifierProvider.notifier)
                          .addHomework(
                              studentEmails: selectedStudentEmails.value,
                              homework: Homework(
                                id: uuid.v4(),
                                myScore: 0,
                                grade: selectedGradeIndex.value + 9,
                                unit: selectedUnitNumber.value + 1,
                                lesson: selectedLessonNumber.value + 1,
                                minScore: int.parse(
                                    minScoreTextEditingController.text),
                                dueDate: dueDate.value,
                                isCompleted: false,
                                teacher: "${teacher?.name} ${teacher!.surname}",
                                teacherId: teacher?.uid ?? "",
                              ));
                      if (res) {
                        CustomSnackbar.show(
                            type: SnackbarType.success(),
                            message: "Görev başarıyla gönderildi",
                            context: context);
                        selectedStudentEmails.value = [];
                        textEditingController.clear();
                        filteredStudents.value = students;
                        dueDate.value = await getCurrentTime();
                        selectedGradeIndex.value = 0;
                        selectedUnitNumber.value = 0;
                        selectedLessonNumber.value = 0;
                        minScoreTextEditingController.clear();
                      } else {
                        CustomSnackbar.show(
                            type: SnackbarType.error(),
                            message: "Görev gönderilirken bir hata oluştu",
                            context: context);
                      }
                      Navigator.pop(context);
                    },
                    child: Text(
                      "Evet",
                      style: GoogleFonts.montserrat(
                          color: textColor, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              );
            });
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: homeworksColor,
          borderRadius: BorderRadius.circular(12),
        ),
        margin: const EdgeInsets.only(
          bottom: 80,
        ),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Görevleri Ata",
              style: TextStyle(color: Colors.white),
            ),
            Gap(8),
            Icon(
              Icons.send,
              size: 20,
              color: Colors.white,
            )
          ],
        ),
      ),
    );
  }
}
