import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:teneffus/auth/presentation/auth_notifier.dart';
import 'package:teneffus/avatars.dart';
import 'package:teneffus/constants.dart';
import 'package:teneffus/global_entities/student_stat.dart';
import 'package:teneffus/global_entities/word_stat.dart';
import 'package:teneffus/global_widgets/custom_circular_progress_indicator.dart';
import 'package:teneffus/homeworks/presentation/notifiers/homeworks_notifier.dart';
import 'package:teneffus/profile/presentation/pages/avatar_selection_page.dart';
import 'package:teneffus/profile/presentation/widgets/stat_banner.dart';
import 'package:teneffus/students/presentation/students_notifier.dart';

import '../../../gen/assets.gen.dart';

class ProfilePage extends HookConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = useState(true);
    final auth = FirebaseAuth.instance;
    final wordStats = useState(<WordStat>[]);
    final stats = useState<StudentStat>(StudentStat.empty());
    final user = ref.watch(studentInformationProvider);

    useEffect(() {
      Future.microtask(() async {
        final result = await ref
            .read(studentsNotifierProvider.notifier)
            .getWordStats(auth.currentUser?.email ?? "");

        wordStats.value = result ?? [];

        final statsResult = await ref
            .read(studentsNotifierProvider.notifier)
            .getStudentStat(auth.currentUser?.email ?? "");

        await ref.read(homeworksNotifierProvider.notifier).getHomeworks(
              uid: ref
                      .read(authNotifierProvider.notifier)
                      .studentInformation
                      ?.uid ??
                  "",
            );

        stats.value = statsResult ?? StudentStat.empty();

        isLoading.value = false;
      });
      return null;
    }, []);

    int correctAnswerCount = 0;
    wordStats.value.isNotEmpty
        ? wordStats.value
            .forEach((stat) => correctAnswerCount += stat.correctCount)
        : 0;

    int numberOfAnswers = 0;
    wordStats.value.isNotEmpty
        ? wordStats.value.forEach((stat) => numberOfAnswers +=
            stat.correctCount + stat.incorrectCount + stat.passedCount)
        : 0;

    String formatRatio(double ratio) {
      String fixed1 = ratio.toStringAsFixed(1);
      if (fixed1.endsWith(".0") && ratio < 10) {
        return ratio.toStringAsFixed(2);
      }
      return fixed1;
    }

    final successRatio =
        correctAnswerCount.toDouble() / numberOfAnswers.toDouble() * 100;

    final listeningSuccessRatio = stats.value.listeningCorrectCount /
        (stats.value.listeningCorrectCount +
            stats.value.listeningIncorrectCount +
            stats.value.listeningPassedCount) *
        100;

    final speakingSuccessRatio = stats.value.speakingCorrectCount /
        (stats.value.speakingCorrectCount +
            stats.value.speakingIncorrectCount +
            stats.value.speakingPassedCount) *
        100;
    final writingSuccessRatio = stats.value.writingCorrectCount /
        (stats.value.writingCorrectCount +
            stats.value.writingIncorrectCount +
            stats.value.writingPassedCount) *
        100;
    final sentenceMakingSuccessRatio = stats.value.sentenceMakingCorrectCount /
        (stats.value.sentenceMakingCorrectCount +
            stats.value.sentenceMakingIncorrectCount +
            stats.value.sentenceMakingPassedCount) *
        100;
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
    return NotificationListener(
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
        child: isLoading.value
            ? const Center(
                child: CustomCircularProgressIndicator(
                disableBackgroundColor: true,
              ))
            : CustomScrollView(
                controller: scrollController,
                slivers: [
                  SliverAppBar(
                    shadowColor: profileColor.withValues(alpha: .2),
                    pinned: true,
                    backgroundColor: const Color(0xfff5f5f5),
                    expandedHeight: 250,
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
                              Padding(
                                padding: EdgeInsets.all(
                                  shuffledAvatars[user?.avatarId ?? 0]!.isBig
                                      ? 4
                                      : 0,
                                ),
                                child: shuffledAvatars[user?.avatarId ?? 0]!
                                    .image
                                    .image(
                                      width: 24,
                                      height: 24,
                                      fit: BoxFit.contain,
                                    ),
                              ),
                              const Gap(4),
                              Text("Hesabım",
                                  style: GoogleFonts.montserrat(
                                      fontSize: 18,
                                      color: textColor,
                                      fontWeight: FontWeight.bold)),
                              const Spacer(),
                            ],
                          ),
                        ),
                      ),
                      background: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 16),
                        color: const Color(0xfff5f5f5),
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
                                const Gap(40),
                                Text("HESABIM",
                                    style: GoogleFonts.balooChettan2(
                                      color: textColor,
                                      fontSize: 32,
                                      fontWeight: FontWeight.bold,
                                    )),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildListDelegate([
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Gap(8),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) =>
                                              const AvatarSelectionPage()),
                                    );
                                  },
                                  child: Stack(
                                    clipBehavior: Clip.none,
                                    children: [
                                      SizedBox(
                                        width: 80,
                                        height: 80,
                                        child: Card(
                                          shadowColor: profileColor,
                                          child: Padding(
                                            padding: EdgeInsets.all(
                                              shuffledAvatars[
                                                          user?.avatarId ?? 0]!
                                                      .isBig
                                                  ? 20
                                                  : 8.0,
                                            ),
                                            child: shuffledAvatars[
                                                    user?.avatarId ?? 0]!
                                                .image
                                                .image(
                                                  width: 90,
                                                  height: 90,
                                                  fit: BoxFit.contain,
                                                ),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        right: -2,
                                        bottom: -2,
                                        child: Container(
                                            padding: const EdgeInsets.all(4),
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: textColor.withValues(
                                                  alpha: .6),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.black
                                                      .withValues(alpha: .2),
                                                  offset: const Offset(0, 2),
                                                  blurRadius: 4,
                                                ),
                                              ],
                                            ),
                                            child: const Icon(
                                              Icons.edit,
                                              size: 12,
                                              color: Colors.white,
                                            )),
                                      ),
                                    ],
                                  ),
                                ),
                                const Gap(8),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("${user?.name} ${user?.surname}"),
                                    Text(
                                        style: const TextStyle(fontSize: 12),
                                        user?.grade != null
                                            ? "${user!.grade}. Sınıf"
                                            : "Sınıf: Bilinmiyor"),
                                    const Gap(8),
                                    Text(user?.email ?? "E-posta: Bilinmiyor",
                                        style: const TextStyle(fontSize: 10)),
                                  ],
                                ),
                                const Gap(16),
                              ],
                            ),
                            const Gap(16),
                            StatBanner(
                                title: "Genel Başarı Yüzdesi",
                                isEmpty: wordStats.value.isEmpty,
                                value: "%${successRatio.toStringAsFixed(1)}",
                                icon: Assets.images.overrallSuccess,
                                color: const Color(0xff9C7CFF)),
                            const Gap(8),
                            StatBanner(
                                title: "Cevaplanan Soru Sayısı",
                                isEmpty: wordStats.value.isEmpty,
                                icon: Assets.images.answeredQuestion,
                                value: "${numberOfAnswers.toString()} soru",
                                color: const Color(0xffFF6B6B)),
                            const Gap(20),
                            Row(
                              children: [
                                const Gap(32),
                                Expanded(
                                  child: Divider(
                                    height: 1,
                                    thickness: 2,
                                    color: textColor.withValues(alpha: .7),
                                  ),
                                ),
                                const Gap(12),
                                const Text("Beceri İstatistikleri"),
                                const Gap(12),
                                Expanded(
                                  child: Divider(
                                    height: 1,
                                    thickness: 2,
                                    color: textColor.withValues(alpha: .7),
                                  ),
                                ),
                                const Gap(32),
                              ],
                            ),
                            const Gap(16),
                            StatBanner(
                              title: "Dinleme",
                              isEmpty: false,
                              count: stats.value.listeningCorrectCount +
                                  stats.value.listeningIncorrectCount +
                                  stats.value.listeningPassedCount,
                              value: "%${formatRatio(listeningSuccessRatio)}",
                              icon: Assets.images.listening,
                              color: listeningBackgroundColor,
                            ),
                            StatBanner(
                              title: "Yazma",
                              isEmpty: false,
                              value: "%${formatRatio(writingSuccessRatio)}",
                              count: stats.value.writingCorrectCount +
                                  stats.value.writingIncorrectCount +
                                  stats.value.writingPassedCount,
                              icon: Assets.images.writing,
                              color: writingBackgroundColor,
                            ),
                            StatBanner(
                              title: "Konuşma",
                              isEmpty: false,
                              value: "%${formatRatio(100)}",
                              count: stats.value.speakingCorrectCount +
                                  stats.value.speakingIncorrectCount +
                                  stats.value.speakingPassedCount,
                              icon: Assets.images.speaking,
                              color: speakingBackgroundColor,
                            ),
                            StatBanner(
                              title: "Cümle Kurma",
                              isEmpty: false,
                              value:
                                  "%${formatRatio(sentenceMakingSuccessRatio)}",
                              count: stats.value.sentenceMakingCorrectCount +
                                  stats.value.sentenceMakingIncorrectCount +
                                  stats.value.sentenceMakingPassedCount,
                              icon: Assets.images.sentenceMaking,
                              color: sentenceMakingBackgroundColor,
                              // child: Column(
                              //   children: [
                              //     Row(
                              //       mainAxisAlignment:
                              //           MainAxisAlignment.spaceEvenly,
                              //       children: [
                              //         StatContainer(
                              //           title: "Dinleme",
                              //           totalValue: stats
                              //                   .value.listeningCorrectCount +
                              //               stats
                              //                   .value.listeningIncorrectCount +
                              //               stats.value.listeningPassedCount,
                              //           isEmpty: listeningSuccessRatio.isNaN,
                              //           value:
                              //               "%${listeningSuccessRatio.toStringAsFixed(1)} başarı",
                              //           color: listeningForegroundColor,
                              //         ),
                              //         StatContainer(
                              //           totalValue: stats
                              //                   .value.speakingCorrectCount +
                              //               stats.value.speakingIncorrectCount +
                              //               stats.value.speakingPassedCount,
                              //           title: "Konuşma",
                              //           isEmpty: speakingSuccessRatio.isNaN,
                              //           value:
                              //               "%${speakingSuccessRatio.toStringAsFixed(1)} başarı",
                              //           color: speakingBackgroundColor,
                              //         ),
                              //       ],
                              //     ),
                              //     const Gap(24),
                              //     Row(
                              //       mainAxisAlignment:
                              //           MainAxisAlignment.spaceEvenly,
                              //       children: [
                              //         StatContainer(
                              //             totalValue: stats
                              //                     .value.writingCorrectCount +
                              //                 stats
                              //                     .value.writingIncorrectCount +
                              //                 stats.value.writingPassedCount,
                              //             title: "Yazma",
                              //             isEmpty: writingSuccessRatio.isNaN,
                              //             value:
                              //                 "%${writingSuccessRatio.toStringAsFixed(1)} başarı",
                              //             color: writingForegroundColor),
                              //         StatContainer(
                              //           totalValue: stats.value
                              //                   .sentenceMakingCorrectCount +
                              //               stats.value
                              //                   .sentenceMakingIncorrectCount +
                              //               stats.value
                              //                   .sentenceMakingPassedCount,
                              //           title: "Cümle Kurma",
                              //           isEmpty:
                              //               sentenceMakingSuccessRatio.isNaN,
                              //           value:
                              //               "%${sentenceMakingSuccessRatio.toStringAsFixed(1)} başarı",
                              //           color: sentenceMakingForegroundColor,
                              //       ),
                              //     ],
                              //   ),
                              // ],
                              // ),
                            ),
                            const Gap(1000)
                          ],
                        ),
                      ),
                    ]),
                  ),
                ],
              ));
  }
}
