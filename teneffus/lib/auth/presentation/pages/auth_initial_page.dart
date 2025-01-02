import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:teneffus/auth/presentation/auth_notifier.dart';
import 'package:teneffus/auth/presentation/pages/auth_page.dart';
import 'package:teneffus/constants.dart';
import 'package:teneffus/global_widgets/stroked_text.dart';

class AuthInitialPage extends HookConsumerWidget {
  const AuthInitialPage({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            StrokedText(
              "Teneffüs'e hoş geldin!",
              strokeWidth: 2.5,
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall!
                  .copyWith(shadows: [textShadowSmall]),
            ),
            const Gap(32),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                StrokedText(
                  "Daha önce giriş yaptın mı?",
                  strokeWidth: 2.5,
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(shadows: [textShadowSmall]),
                ),
                const Gap(8),
                InkWell(
                  onTap: () async {
                    await ref
                        .read(carouselControllerProvider)
                        .animateToPage(curve: slideAnimationCurve, 1);
                  },
                  overlayColor:
                      const WidgetStatePropertyAll(Colors.transparent),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: StrokedText(
                          "Süper! O zaman giriş adımına geçelim.",
                          strokeWidth: 1.5,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(shadows: [textShadowSmall]),
                        ),
                      ),
                      const Icon(
                        Icons.chevron_right_rounded,
                        size: 64,
                        color: Colors.white,
                      )
                    ],
                  ),
                )
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                StrokedText(
                  "Arapça öğrenme serüvenine henüz başlamadın mı?",
                  strokeWidth: 2.5,
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(shadows: [textShadowSmall]),
                ),
                const Gap(8),
                InkWell(
                  onTap: () async {
                    await ref
                        .read(authNotifierProvider.notifier)
                        .redirectToRegister();
                    ref
                        .read(carouselControllerProvider)
                        .animateToPage(curve: slideAnimationCurve, 1);
                  },
                  overlayColor:
                      const WidgetStatePropertyAll(Colors.transparent),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: StrokedText(
                          "Sorun yok. Buradan hızlıca yeni bir hesap oluşturabilirsin.",
                          strokeWidth: 1.5,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(shadows: [textShadowSmall]),
                        ),
                      ),
                      const Icon(
                        Icons.chevron_right_rounded,
                        size: 64,
                        color: Colors.white,
                      )
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
