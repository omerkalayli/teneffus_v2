import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:teneffus/auth/presentation/auth_notifier.dart';
import 'package:teneffus/avatars.dart';
import 'package:teneffus/constants.dart';
import 'package:teneffus/gen/assets.gen.dart';

/// A widget that displays a user badge with a rank and star count.

class UserBadge extends HookConsumerWidget {
  const UserBadge({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userInfo = ref.watch(studentInformationProvider);
    return Column(
      children: [
        Card(
          margin: const EdgeInsets.all(16),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                gradient: LinearGradient(
                  colors: [
                    buttonForegroundColorBlue.withValues(alpha: 0.5),
                    buttonForegroundColorBlue.withValues(alpha: 0.2),
                  ],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                )),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
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
                  child: shuffledAvatars[userInfo?.avatarId]
                      ?.image
                      .image(width: 80, height: 80, color: Colors.black),
                ),
                const Gap(4),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          style: GoogleFonts.montserrat(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                          "${userInfo?.name} ${userInfo?.surname}"),
                      Text(
                        "${userInfo?.grade}. Sınıf",
                        style: GoogleFonts.montserrat(
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
                  child: Row(
                    children: [
                      const Gap(8),
                      Text(
                        userInfo?.starCount.toString() ?? "0",
                        style: GoogleFonts.montserrat(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Colors.orange),
                      ),
                      ClipRect(
                        child: Align(
                          alignment: Alignment.center,
                          widthFactor: 0.6,
                          heightFactor: 0.6,
                          child: Assets.animations.star.lottie(
                            width: 64,
                            height: 64,
                            fit: BoxFit.contain,
                            alignment: Alignment.center,
                            repeat: true,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
