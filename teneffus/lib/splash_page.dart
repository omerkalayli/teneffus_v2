import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:teneffus/app_router.gr.dart';
import 'package:teneffus/auth/presentation/auth_notifier.dart';
import 'package:teneffus/global_widgets/custom_circular_progress_indicator.dart';
import 'package:teneffus/global_widgets/custom_scaffold.dart';

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
            await ref
                .read(authNotifierProvider.notifier)
                .getStudentInformation();
          } else {
            await ref
                .read(authNotifierProvider.notifier)
                .getTeacherInformation();
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
