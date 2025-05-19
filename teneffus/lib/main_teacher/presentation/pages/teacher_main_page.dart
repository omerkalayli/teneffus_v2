import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:teneffus/auth/presentation/auth_notifier.dart';
import 'package:teneffus/constants.dart';
import 'package:teneffus/global_widgets/custom_scaffold.dart';
import 'package:teneffus/global_widgets/stroked_text.dart';

class TeacherMainPage extends HookConsumerWidget {
  const TeacherMainPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final teacher = ref.watch(authNotifierProvider.notifier).teacherInformation;

    return CustomScaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                StrokedText(
                  "${teacher?.name} ${teacher?.surname}",
                  strokeWidth: 2,
                  style: const TextStyle(fontSize: 20, shadows: [headerShadow]),
                ),
                const Spacer(),
                InkWell(
                  onTap: () {
                    ref.read(authNotifierProvider.notifier).signOut();
                  },
                  child: const Icon(
                    Icons.settings_rounded,
                    color: Colors.white,
                    size: 28,
                  ),
                )
              ],
            )
          ],
        ),
      )),
    );
  }
}
