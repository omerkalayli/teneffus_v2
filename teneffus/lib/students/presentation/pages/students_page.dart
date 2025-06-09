import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:teneffus/auth/domain/entities/student_information.dart';
import 'package:teneffus/auth/presentation/auth_notifier.dart';
import 'package:teneffus/games/presentation/widgets/custom_dropdown.dart';
import 'package:teneffus/global_widgets/custom_scaffold.dart';
import 'package:teneffus/global_widgets/student_search_bar.dart';
import 'package:teneffus/students/presentation/students_notifier.dart';

/// [StudentsPage] is the page where teachers can see their students.

class StudentsPage extends HookConsumerWidget {
  const StudentsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final teacher = ref.watch(teacherInformationProvider);
    final students = teacher?.students ?? [];
    final isLoading = useState(false);
    final selectedGrade = useState<int>(8);
    final textEditingController = useTextEditingController();
    final filteredStudents = useState<List<StudentInformation>>(students);

    useEffect(() {
      textEditingController.addListener(() {
        filteredStudents.value = students.where((student) {
          final matchesName = student.name
                  .toLowerCase()
                  .contains(textEditingController.text.toLowerCase()) ||
              textEditingController.text.isEmpty;
          final matchesGrade =
              selectedGrade.value == 8 || student.grade == selectedGrade.value;
          return matchesName && matchesGrade;
        }).toList();
      });

      return;
    }, [
      textEditingController.text,
      selectedGrade.value,
      isLoading.value,
      students
    ]);

    return CustomScaffold(
      appBar: _appBar(isLoading, ref),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.only(left: 8),
        child: students.isEmpty
            ? const Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.person_off_outlined,
                      color: Colors.white,
                      size: 36,
                    ),
                    Gap(4),
                    Text("Hiç öğrenciniz yok."),
                  ],
                ),
              )
            : SingleChildScrollView(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: StudentSearchBar(
                          textEditingController: textEditingController,
                          selectedStudentGrade: selectedGrade,
                          onSelectionChanged: (index) {
                            selectedGrade.value = index;

                            filteredStudents.value = students.where((student) {
                              final matchesName = student.name
                                      .toLowerCase()
                                      .contains(textEditingController.text
                                          .toLowerCase()) ||
                                  textEditingController.text.isEmpty;
                              final matchesGrade =
                                  index == 8 || student.grade == index;
                              return matchesName && matchesGrade;
                            }).toList();
                          },
                        ),
                      ),
                      ...List.generate(filteredStudents.value.length, (index) {
                        return ListTile(
                          title: Text(
                            "${filteredStudents.value[index].name} ${filteredStudents.value[index].surname}",
                            style: const TextStyle(color: Colors.white),
                          ),
                          subtitle: Text(
                            "${filteredStudents.value[index].grade}. Sınıf",
                            style: const TextStyle(color: Colors.white),
                          ),
                          trailing: InkWell(
                            onTap: () async {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      backgroundColor:
                                          Colors.white.withValues(alpha: .5),
                                      title: const Text("Öğrenciyi Sil"),
                                      content: const Text(
                                          "Bu öğrenciyi silmek istediğinize emin misiniz?"),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
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
                                            await ref
                                                .read(studentsNotifierProvider
                                                    .notifier)
                                                .removeStudent(
                                                  filteredStudents.value[index],
                                                  teacher?.email ?? "",
                                                );
                                            await ref
                                                .read(authNotifierProvider
                                                    .notifier)
                                                .getTeacherInformation();
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
                            child: const Icon(
                              Icons.delete,
                              color: Colors.white,
                            ),
                          ),
                        );
                      }),
                    ]),
              ),
      )),
    );
  }

  AppBar _appBar(ValueNotifier<bool> isLoading, WidgetRef ref) {
    return AppBar(
      backgroundColor: Colors.transparent,
      centerTitle: true,
      title: Text(
        "Öğrencilerim",
        style: GoogleFonts.montserrat(
            color: Colors.white, fontWeight: FontWeight.w700),
      ),
      actions: [
        InkWell(
          onTap: () async {
            isLoading.value = true;
            await ref
                .read(authNotifierProvider.notifier)
                .getTeacherInformation();
            isLoading.value = false;
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            margin: const EdgeInsets.only(right: 8),
            decoration: BoxDecoration(
              color: const Color.fromARGB(208, 33, 149, 243),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                const Text(
                  "Yenile",
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
                const Gap(4),
                isLoading.value
                    ? Container(
                        margin: const EdgeInsets.all(2),
                        height: 12,
                        width: 12,
                        child: const CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ))
                    : const Icon(
                        Icons.refresh,
                        color: Colors.white,
                        size: 16,
                      ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  IntrinsicWidth addStudentButton({
    required Function()? onTap,
  }) {
    return IntrinsicWidth(
      child: InkWell(
        onTap: () {
          onTap?.call();
        },
        child: Container(
          decoration: BoxDecoration(
            color: const Color.fromARGB(171, 18, 82, 134),
            borderRadius: BorderRadius.circular(16),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          margin: const EdgeInsets.only(bottom: 80),
          child: const Row(
            children: [
              Text("Öğrenci Ekle"),
              Gap(2),
              Icon(
                Icons.add,
                color: Colors.white,
              )
            ],
          ),
        ),
      ),
    );
  }
}
