import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:teneffus/auth/presentation/auth_notifier.dart';
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

    return Scaffold(
        backgroundColor: Colors.transparent,
        body: hasTeacher
            ? HomeworksWidget(
                dropdownItems: dropdownItems,
                selectedDropdownIndex: selectedDropdownIndex,
                showEarliestFirst: showEarliestFirst,
                filteredHomeworks: filteredHomeworks,
                onRefresh: () async {
                  final uid = FirebaseAuth.instance.currentUser?.uid ?? "";
                  final notifier = ref.read(homeworksNotifierProvider.notifier);
                  await notifier.getHomeworks(uid: uid);
                },
              )
            : const NoTeacherConnectedWidget());
  }
}
