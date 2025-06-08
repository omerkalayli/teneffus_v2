import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:teneffus/auth/presentation/auth_notifier.dart';
import 'package:teneffus/homeworks/presentation/homeworks_state.dart';
import 'package:teneffus/homeworks/presentation/notifiers/homeworks_notifier.dart';
import 'package:teneffus/homeworks/presentation/pages/homeworks_widget.dart';
import 'package:teneffus/homeworks/presentation/pages/no_teacher_connected_widget.dart';

class HomeworksPage extends HookConsumerWidget {
  const HomeworksPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authNotifierProvider);
    final hasTeacher = authState.value?.maybeWhen(
          authenticated: (studentInfo, teacherInfo) =>
              studentInfo?.teacherUid != null,
          orElse: () => false,
        ) ??
        false;
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

    final state = ref.watch(homeworksNotifierProvider);
    final isLoading = state.value == const HomeworksState.loading();

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          actions: hasTeacher
              ? [
                  InkWell(
                    onTap: () {
                      ref.read(homeworksNotifierProvider.notifier).getHomeworks(
                            uid: ref
                                    .read(authNotifierProvider.notifier)
                                    .studentInformation
                                    ?.uid ??
                                "",
                          );
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
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
                          isLoading
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
                  const Gap(16)
                ]
              : [],
          title: Text('Görevlerim',
              style: GoogleFonts.montserrat(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20)),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: hasTeacher
              ? HomeworksWidget(
                  dropdownItems: dropdownItems,
                  selectedDropdownIndex: selectedDropdownIndex,
                  showEarliestFirst: showEarliestFirst,
                  filteredHomeworks: filteredHomeworks)
              : const NoTeacherConnectedWidget(),
        ));
  }
}
