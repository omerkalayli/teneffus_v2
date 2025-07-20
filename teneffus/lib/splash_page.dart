import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:teneffus/app_router.gr.dart';
import 'package:teneffus/auth/presentation/auth_notifier.dart';
import 'package:teneffus/global_widgets/custom_circular_progress_indicator.dart';
import 'package:teneffus/global_widgets/custom_scaffold.dart';
import 'package:teneffus/students/presentation/students_notifier.dart';
import 'package:teneffus/time.dart';

@RoutePage()
class SplashPage extends HookConsumerWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useEffect(() {
      Future.microtask(() async {
        final user = FirebaseAuth.instance.currentUser;

        if (user != null) {
          String userType = await ref
                  .read(authNotifierProvider.notifier)
                  .getUserType(user.uid) ??
              "student";

          if (userType == "student") {
            final studentInfo = await ref
                .read(authNotifierProvider.notifier)
                .getStudentInformation();

            DateTime? lastLogin = studentInfo?.lastLogin;
            if (lastLogin != null) {
              DateTime now = await getCurrentTime();
              DateTime lastDate =
                  DateTime(lastLogin.year, lastLogin.month, lastLogin.day);
              DateTime todayDate = DateTime(now.year, now.month, now.day);
              int dayDifference = todayDate.difference(lastDate).inDays;

              if (dayDifference == 1) {
                await ref
                    .read(authNotifierProvider.notifier)
                    .updateDayStreak(studentInfo?.dayStreak ?? 1 + 1);
                await ref
                    .read(authNotifierProvider.notifier)
                    .updateLastLoginDate();
              } else if (dayDifference > 1) {
                await ref
                    .read(authNotifierProvider.notifier)
                    .updateDayStreak(0);
                await ref
                    .read(authNotifierProvider.notifier)
                    .updateLastLoginDate();
              }
            }
          } else {
            final res = await ref
                .read(authNotifierProvider.notifier)
                .getTeacherInformation();
            await ref.read(studentsNotifierProvider.notifier).getStudents();
            if (res == null) {
              context.replaceRoute(const AuthRoute());
              return;
            }
          }

          context.replaceRoute(const AuthRoute());
        } else {
          context.replaceRoute(const AuthRoute());
        }
      });
      return null;
    }, []);

    return const CustomScaffold(
      body: Center(
          child: CustomCircularProgressIndicator(
        showAppTitle: true,
        disableBackgroundColor: true,
      )),
    );
  }
}
