import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:teneffus/auth/presentation/auth_notifier.dart';
import 'package:teneffus/avatars.dart';
import 'package:teneffus/constants.dart';
import 'package:teneffus/gen/assets.gen.dart';
import 'package:teneffus/global_widgets/custom_scaffold.dart';
import 'package:teneffus/main/presentation/widgets/sarfia_animation.dart';
import 'package:teneffus/settings/presentation/pages/settings_page.dart';
import 'package:teneffus/students/presentation/students_notifier.dart';

class TeacherMainPage extends HookConsumerWidget {
  const TeacherMainPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final teacher = ref.watch(authNotifierProvider.notifier).teacherInformation;
    final students = useState(List.empty());
    final isLoading = useState(false);
    useEffect(() {
      isLoading.value = true;
      Future.microtask(() async {
        await ref.read(studentsNotifierProvider.notifier).getStudents();
        final val = ref.read(studentsProvider);
        students.value = val
          ..sort((a, b) => b.starCount.compareTo(a.starCount));
        isLoading.value = false;
      });
    }, []);

    return CustomScaffold(
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
              gradient: LinearGradient(
                colors: [
                  const Color(0xff4DD0E1).withValues(alpha: .8),
                  const Color(0xff69AAFF).withValues(alpha: .8),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Column(
              children: [
                Gap(MediaQuery.of(context).padding.top),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Align(
                      alignment: Alignment.centerRight,
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SettingsPage(),
                              ));
                        },
                        child: const Icon(
                          Icons.settings_rounded,
                          color: Colors.white,
                          size: 28,
                        ),
                      )),
                ),
                const SarfiaAnimation(),
                const Gap(80),
                const Padding(
                  padding: EdgeInsets.only(right: 16),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "ÖĞRETMEN",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const Gap(8),
              ],
            ),
          ),
          Card(
            margin: const EdgeInsets.all(16),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                  border: Border.all(width: 2, color: Colors.white),
                  borderRadius: BorderRadius.circular(12),
                  gradient: const LinearGradient(
                    colors: [
                      buttonForegroundColorBlue,
                      buttonForegroundColorBlue
                    ],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  )),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(99),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.white.withValues(alpha: 0.2),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                        color: Colors.white,
                      ),
                      child: const Icon(Icons.person_rounded,
                          color: Colors.black87, size: 40)),
                  const Gap(4),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            style: GoogleFonts.montserrat(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                            "${teacher?.name} ${teacher?.surname}"),
                        Text(
                          "${students.value.length} Öğrenci",
                          style: GoogleFonts.montserrat(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(99),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.white.withValues(alpha: 0.2),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 12),
              width: double.infinity,
              child: Card(
                child: Column(
                  children: [
                    const Gap(16),
                    Text("EN YÜKSEK PUANLI ÖĞRENCİLER",
                        style: GoogleFonts.montserrat(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                        )),
                    if (isLoading.value)
                      const Center(
                        child: CircularProgressIndicator(),
                      )
                    else if (students.value.isEmpty)
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Assets.images.noHomework.image(
                                width: 100, height: 100, color: textColor),
                            const Gap(8),
                            const Text("Hiç öğrenciniz yok.",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: textColor,
                                )),
                            const Gap(16),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(
                                "Öğrenci eklemek için Öğrencilerim sayfasına gidin.",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: textColor.withValues(alpha: 0.7),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    else
                      Column(
                        children: [
                          const Gap(16),
                          ...List.generate(students.value.length, (index) {
                            final student = students.value[index];
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 2),
                              child: ListTile(
                                tileColor: index == 0
                                    ? Colors.green.withValues(alpha: 0.1)
                                    : index == 1
                                        ? Colors.yellow.withValues(alpha: 0.1)
                                        : index == 2
                                            ? Colors.orange
                                                .withValues(alpha: 0.1)
                                            : index.isEven
                                                ? Colors.black
                                                    .withValues(alpha: 0.1)
                                                : Colors.transparent,
                                leading: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: shuffledAvatars[student.avatarId]
                                      ?.image
                                      .image(
                                        fit: BoxFit.contain,
                                        width: 36,
                                        height: 36,
                                      ),
                                ),
                                titleTextStyle: GoogleFonts.montserrat(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                                title:
                                    Text("${student.name} ${student.surname}"),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 4.0),
                                      child: Text(
                                        "${student.starCount}",
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
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
                            );
                          })
                        ],
                      ),
                    const Gap(16),
                  ],
                ),
              ),
            ),
          ),
          const Gap(88),
        ],
      ),
    );
  }
}
