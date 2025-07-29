import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:teneffus/auth/domain/entities/student_information.dart';
import 'package:teneffus/auth/domain/entities/teacher_information.dart';
import 'package:teneffus/auth/presentation/auth_notifier.dart';
import 'package:teneffus/constants.dart';
import 'package:teneffus/gen/assets.gen.dart';
import 'package:teneffus/global_widgets/student_search_bar.dart';
import 'package:teneffus/students/presentation/students_notifier.dart';

/// [StudentsPage] is the page where teachers can see their students.

class StudentsPage extends HookConsumerWidget {
  const StudentsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final teacher = ref.watch(teacherInformationProvider);
    List<StudentInformation> students = ref.watch(studentsProvider);
    final isLoading = useState(true);
    final selectedGrade = useState<int>(8);
    final textEditingController = useTextEditingController();
    final filteredStudents = useState<List<StudentInformation>>(students);
    final isAscending = useState<bool>(true);

    useEffect(() {
      Future.microtask(() async {
        isLoading.value = true;
        Future.delayed(const Duration(milliseconds: 1000), () {});
        textEditingController.clear();
        await ref.read(studentsNotifierProvider.notifier).getStudents();
        filteredStudents.value = ref.watch(studentsProvider);
        isLoading.value = false;
      });
      return;
    }, []);

    useEffect(() {
      textEditingController.addListener(() {
        List<StudentInformation> filtered = students.where((student) {
          final matchesName = student.name
                  .toLowerCase()
                  .contains(textEditingController.text.toLowerCase()) ||
              student.surname
                  .toLowerCase()
                  .contains(textEditingController.text.toLowerCase()) ||
              textEditingController.text.isEmpty;
          final matchesGrade =
              selectedGrade.value == 8 || student.grade == selectedGrade.value;
          return matchesName && matchesGrade;
        }).toList();

        filtered.sort((a, b) => isAscending.value
            ? a.starCount.compareTo(b.starCount)
            : b.starCount.compareTo(a.starCount));
        filteredStudents.value = filtered;
      });
      final sorted = List<StudentInformation>.from(filteredStudents.value)
        ..sort((a, b) => isAscending.value
            ? a.starCount.compareTo(b.starCount)
            : b.starCount.compareTo(a.starCount));

      filteredStudents.value = sorted;
      return;
    }, [
      textEditingController.text,
      selectedGrade.value,
      students,
      isLoading.value,
      isAscending.value,
    ]);

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
      color: textColor,
      onRefresh: () async {
        await Future.delayed(const Duration(milliseconds: 500), () {});
        isLoading.value = true;
        textEditingController.clear();
        await ref.read(studentsNotifierProvider.notifier).getStudents();
        isLoading.value = false;
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
        child: CustomScrollView(
          controller: scrollController,
          slivers: [
            SliverAppBar(
              shadowColor: profileColor.withValues(alpha: .2),
              pinned: true,
              backgroundColor: const Color(0xfff5f5f5),
              expandedHeight: 338,
              toolbarHeight: 56,
              flexibleSpace: appBar(
                  percentScrolled,
                  scrollController,
                  isAscending,
                  textEditingController,
                  selectedGrade,
                  filteredStudents,
                  students,
                  context),
            ),
            SliverList(
                delegate:
                    SliverChildListDelegate(students.isEmpty && !isLoading.value
                        ? _noStudentWidget
                        : [
                            const Gap(16),
                            if (filteredStudents.value.isEmpty &&
                                !isLoading.value)
                              Center(
                                child: Column(
                                  children: [
                                    const Gap(32),
                                    Assets.images.noUser.image(
                                      width: 32,
                                      height: 32,
                                      color: textColor,
                                    ),
                                    const Gap(4),
                                    const Text(
                                      "Öğrenci bulunamadı.",
                                      style: TextStyle(color: textColor),
                                    ),
                                  ],
                                ),
                              )
                            else if (isLoading.value)
                              Column(
                                  children: List.generate(5, (index) {
                                return Skeletonizer(
                                    child: Card(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 4),
                                  child: ListTile(
                                    leading: const CircleAvatar(
                                      radius: 20,
                                      backgroundColor: Colors.white,
                                    ),
                                    title: Container(
                                      height: 16,
                                      width: 100,
                                      color: Colors.white,
                                    ),
                                    subtitle: Container(
                                      height: 12,
                                      width: 80,
                                      color: Colors.white,
                                    ),
                                  ),
                                ));
                              }))
                            else
                              ...List.generate(
                                filteredStudents.value.length,
                                (index) {
                                  return GestureDetector(
                                    onLongPress: () {
                                      _deleteStudentDialog(context, ref,
                                          filteredStudents, index, teacher);
                                    },
                                    child: Card(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 16, vertical: 4),
                                      child: ListTile(
                                        dense: true,
                                        title: Text(
                                          "${filteredStudents.value[index].name} ${filteredStudents.value[index].surname}",
                                          style: const TextStyle(
                                              color: textColor, fontSize: 14),
                                        ),
                                        subtitle: Text(
                                          "${filteredStudents.value[index].grade}. Sınıf",
                                          style: const TextStyle(
                                              color: textColor, fontSize: 12),
                                        ),
                                        trailing: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.only(top: 2),
                                              child: Text(
                                                filteredStudents
                                                    .value[index].starCount
                                                    .toString(),
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                  color: textColor,
                                                ),
                                              ),
                                            ),
                                            const Gap(4),
                                            Assets.images.star2.image(
                                              width: 18,
                                              height: 18,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            const Gap(1000)
                          ])),
          ],
        ),
      ),
    );
  }

  Future<dynamic> _deleteStudentDialog(
      BuildContext context,
      WidgetRef ref,
      ValueNotifier<List<StudentInformation>> filteredStudents,
      int index,
      TeacherInformation? teacher) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            title: const Text("Öğrenciyi Sil"),
            content:
                const Text("Bu öğrenciyi silmek istediğinize emin misiniz?"),
            actions: [
              TextButton(
                onPressed: () {
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
                  await ref
                      .read(studentsNotifierProvider.notifier)
                      .removeStudent(
                        filteredStudents.value[index],
                        teacher?.email ?? "",
                      );
                  await ref
                      .read(authNotifierProvider.notifier)
                      .getTeacherInformation();
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
  }

  Padding _header(
      ValueNotifier<bool> isAscending,
      TextEditingController textEditingController,
      ValueNotifier<int> selectedGrade,
      ValueNotifier<List<StudentInformation>> filteredStudents,
      List<StudentInformation> students) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: StudentSearchBar(
        isAscending: isAscending,
        textEditingController: textEditingController,
        selectedStudentGrade: selectedGrade,
        onSelectionChanged: (index) {
          selectedGrade.value = index;

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
    );
  }

  List<Widget> get _noStudentWidget {
    return [
      Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Gap(32),
            Assets.images.noUser.image(
              width: 32,
              height: 32,
              color: textColor,
            ),
            const Gap(4),
            const Text("Hiç öğrenciniz yok."),
          ],
        ),
      )
    ];
  }

  FlexibleSpaceBar appBar(
    double percentScrolled,
    ScrollController scrollController,
    ValueNotifier<bool> isAscending,
    TextEditingController textEditingController,
    ValueNotifier<int> selectedGrade,
    ValueNotifier<List<StudentInformation>> filteredStudents,
    List<StudentInformation> students,
    BuildContext context,
  ) {
    return FlexibleSpaceBar(
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
              Text("Öğrencilerim",
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
            color: gamesColor),
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
                    child: Text("ÖĞRENCİLERİM",
                        style: GoogleFonts.balooChettan2(
                          color: Colors.white,
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                ),
                _header(isAscending, textEditingController, selectedGrade,
                    filteredStudents, students),
                const Gap(8),
              ],
            ),
          ),
        ),
      ),
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
                color: textColor,
              )
            ],
          ),
        ),
      ),
    );
  }
}
