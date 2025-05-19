import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:teneffus/auth/presentation/auth_notifier.dart';
import 'package:teneffus/global_widgets/custom_scaffold.dart';

class StudentsPage extends HookConsumerWidget {
  const StudentsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final teacher = ref.watch(authNotifierProvider.notifier).teacherInformation;
    final students = teacher?.students ?? [];
    return CustomScaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          "Öğrencilerim",
          style: GoogleFonts.montserrat(
              color: Colors.white, fontWeight: FontWeight.w700),
        ),
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: SingleChildScrollView(
            child: students.isEmpty
                ? const Text("Hiç öğrenciniz yok.")
                : Column(
                    children: List.generate(students.length, (index) {
                      return ListTile(
                        title: Text(students[index].name),
                        subtitle: Text(students[index].surname),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            // Handle delete action
                          },
                        ),
                      );
                    }),
                  ),
          ),
        ),
      )),
    );
  }

  IntrinsicWidth addStudentButton({required Function()? onTap}) {
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
