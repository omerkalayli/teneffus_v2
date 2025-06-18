import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:teneffus/arabic/getter/getter.dart';
import 'package:teneffus/auth/domain/entities/student_information.dart';
import 'package:teneffus/auth/presentation/auth_notifier.dart';
import 'package:teneffus/games/presentation/widgets/custom_dropdown.dart';
import 'package:teneffus/global_entities/lesson.dart';
import 'package:teneffus/global_entities/snackbar_type.dart';
import 'package:teneffus/global_entities/unit.dart';
import 'package:teneffus/global_widgets/custom_scaffold.dart';
import 'package:teneffus/global_widgets/custom_snackbar.dart';
import 'package:teneffus/global_widgets/student_search_bar.dart';
import 'package:teneffus/homeworks/domain/entities/homework.dart';
import 'package:teneffus/homeworks/presentation/notifiers/homeworks_notifier.dart';
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
    final dueDate = useState(DateTime.now());

    final teacher = ref.watch(teacherInformationProvider);
    final students = teacher?.students ?? [];
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

    return CustomScaffold(
      flotingActionButton: selectedStudentEmails.value.isNotEmpty
          ? GestureDetector(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        backgroundColor:
                            Colors.lightBlueAccent.withValues(alpha: .75),
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
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
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
                                      studentEmails:
                                          selectedStudentEmails.value,
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
                                        teacher:
                                            "${teacher?.name} ${teacher!.surname}",
                                        teacherId: teacher.uid,
                                      ));
                              if (res) {
                                CustomSnackbar.show(
                                    type: SnackbarType.success(),
                                    message: "Görev başarıyla gönderildi",
                                    context: context);
                                selectedStudentEmails.value = [];
                                textEditingController.clear();
                                filteredStudents.value = students;
                                dueDate.value = DateTime.now();
                                selectedGradeIndex.value = 0;
                                selectedUnitNumber.value = 0;
                                selectedLessonNumber.value = 0;
                                minScoreTextEditingController.clear();
                              } else {
                                CustomSnackbar.show(
                                    type: SnackbarType.error(),
                                    message:
                                        "Görev gönderilirken bir hata oluştu",
                                    context: context);
                              }
                              Navigator.pop(context);
                            },
                            child: Text(
                              "Evet",
                              style: GoogleFonts.montserrat(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      );
                    });
              },
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.green,
                  border: Border.all(width: 2, color: Colors.white),
                  borderRadius: BorderRadius.circular(12),
                ),
                margin: const EdgeInsets.only(
                  bottom: 56,
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("Görevleri Ata"),
                    Gap(8),
                    Icon(
                      Icons.send,
                      size: 20,
                      color: Colors.white,
                    )
                  ],
                ),
              ),
            )
          : null,
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          centerTitle: true,
          title: Text(
            "Görev Oluştur",
            style: GoogleFonts.montserrat(
                color: Colors.white, fontWeight: FontWeight.w700),
          )),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _homeworkInfoHeader(
                  selectedGradeIndex,
                  selectedUnitNumber,
                  selectedLessonNumber,
                  units,
                  minScoreTextEditingController,
                  lessons,
                  context,
                  dueDate),
              const Gap(16),
              studentSelection(textEditingController, selectedStudentGrade,
                  filteredStudents, students, selectedStudentEmails)
            ],
          ),
        ),
      ),
    );
  }

  Column studentSelection(
      TextEditingController textEditingController,
      ValueNotifier<int> selectedStudentGrade,
      ValueNotifier<List<StudentInformation>> filteredStudents,
      List<StudentInformation> students,
      ValueNotifier<List<String>> selectedStudentEmails) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            "Görev Atanacak Öğrenciler",
            style: TextStyle(fontSize: 16),
          ),
        ),
        const Gap(4),
        StudentSearchBar(
          textEditingController: textEditingController,
          selectedStudentGrade: selectedStudentGrade,
          onSelectionChanged: (index) {
            selectedStudentGrade.value = index + 8; // 9th grade is index 0
            filteredStudents.value = students.where((student) {
              final matchesName = student.name
                      .toLowerCase()
                      .contains(textEditingController.text.toLowerCase()) ||
                  textEditingController.text.isEmpty;
              final matchesGrade = index == 8 || student.grade == index;
              return matchesName && matchesGrade;
            }).toList();
          },
        ),
        filteredStudents.value.isEmpty
            ? const Center(
                child: Padding(
                  padding: EdgeInsets.all(24.0),
                  child: Text(
                    "Öğrenci bulunamadı",
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                ),
              )
            : SingleChildScrollView(
                child: Column(
                  children:
                      List.generate(filteredStudents.value.length, (index) {
                    return InkWell(
                      overlayColor:
                          const WidgetStatePropertyAll(Colors.transparent),
                      onTap: () {
                        bool value = selectedStudentEmails.value
                            .contains(filteredStudents.value[index].email);
                        if (!value) {
                          List<String> emails = [
                            ...selectedStudentEmails.value
                          ];
                          emails.add(filteredStudents.value[index].email);
                          selectedStudentEmails.value = emails;
                        } else {
                          List<String> emails = [
                            ...selectedStudentEmails.value
                          ];
                          emails.remove(filteredStudents.value[index].email);
                          selectedStudentEmails.value = emails;
                        }
                      },
                      child: ListTile(
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        title: Text(
                          "${filteredStudents.value[index].name} ${filteredStudents.value[index].surname}",
                          style: const TextStyle(
                              color: Colors.white, fontSize: 16),
                        ),
                        subtitle: Text(
                          "${filteredStudents.value[index].grade}. Sınıf",
                          style: const TextStyle(
                              fontSize: 14, color: Colors.white),
                        ),
                        trailing: Checkbox(
                          side: const BorderSide(color: Colors.white, width: 2),
                          fillColor: WidgetStatePropertyAll(
                              selectedStudentEmails.value.contains(
                                      filteredStudents.value[index].email)
                                  ? Colors.blue
                                  : Colors.transparent),
                          value: selectedStudentEmails.value
                              .contains(filteredStudents.value[index].email),
                          onChanged: (value) {
                            if (value == true) {
                              List<String> emails = [
                                ...selectedStudentEmails.value
                              ];
                              emails.add(filteredStudents.value[index].email);
                              selectedStudentEmails.value = emails;
                            } else {
                              List<String> emails = [
                                ...selectedStudentEmails.value
                              ];
                              emails
                                  .remove(filteredStudents.value[index].email);
                              selectedStudentEmails.value = emails;
                            }
                          },
                        ),
                      ),
                    );
                  }),
                ),
              ),
      ],
    );
  }

  Column _homeworkInfoHeader(
      ValueNotifier<int> selectedGradeIndex,
      ValueNotifier<int> selectedUnitNumber,
      ValueNotifier<int> selectedLessonNumber,
      List<Unit> units,
      TextEditingController minScoreTextEditingController,
      List<Lesson> lessons,
      BuildContext context,
      ValueNotifier<DateTime> dueDate) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 8.0, bottom: 4),
                  child: Text("Sınıf"),
                ),
                CustomDropdown(
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
                  child: Text("Ünite"),
                ),
                CustomDropdown(
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
                        "Geçme Notu"), // TODO: gecme notu yerine dogru yuzdesi ya da sayisi olmlaı bence
                  ),
                  SizedBox(
                    height: 30,
                    width: 120,
                    child: TextField(
                      controller: minScoreTextEditingController,
                      cursorColor: Colors.white,
                      style: const TextStyle(color: Colors.white, fontSize: 12),
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
                  child: Text("Konu"),
                ),
                CustomDropdown(
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
              child: Text("Bitiş Tarihi"),
            ),
            InkWell(
              onTap: () {
                showDatePicker(
                  locale: const Locale("tr", "TR"),
                  context: context,
                  initialDate: dueDate.value,
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2100),
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
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "${dueDate.value.day}/${dueDate.value.month}/${dueDate.value.year}",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
