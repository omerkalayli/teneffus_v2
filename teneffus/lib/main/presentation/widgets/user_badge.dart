import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:teneffus/auth/presentation/auth_notifier.dart';
import 'package:teneffus/gen/assets.gen.dart';

/// A widget that displays a user badge with a rank and star count.

class UserBadge extends HookConsumerWidget {
  const UserBadge({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userInfo = ref.watch(authNotifierProvider.notifier).userInformation;
    const double minBarWidth = 64;
    const double maxBarWidth = 140;
    final double ratio = ((userInfo?.starCount ?? 0) / 100).clamp(0.0, 1.0);
    final shadow = BoxShadow(
        color: Colors.black.withValues(alpha: 0.4),
        offset: const Offset(0, 4),
        blurRadius: 4);
    return Stack(
      alignment: Alignment.centerLeft,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(left: 48),
              padding:
                  const EdgeInsets.only(left: 24, right: 24, top: 2, bottom: 2),
              decoration: const BoxDecoration(
                  border: Border(
                    top: BorderSide(width: 2),
                    right: BorderSide(width: 2),
                  ),
                  color: Color(0xff1B6B8A),
                  borderRadius:
                      BorderRadius.only(topRight: Radius.circular(8))),
              child: Text(
                userInfo?.rank ?? "Unranked",
                style: const TextStyle(fontSize: 10),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 48.0),
              child: Stack(
                children: [
                  // Background bar
                  Container(
                    width: 140,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      boxShadow: [shadow],
                      color: Colors.white,
                      border: Border.all(width: 2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Text(
                      "",
                      style: TextStyle(fontSize: 14),
                    ),
                  ),

                  // Progress bar
                  AnimatedContainer(
                    duration: Durations.short4,
                    width: minBarWidth + (maxBarWidth - minBarWidth) * ratio,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xffFECF00),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(width: 2),
                    ),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            userInfo?.starCount.toString() ?? "0",
                            style: const TextStyle(
                                fontSize: 14, color: Colors.black),
                          ),
                          const Stack(
                            alignment: Alignment.center,
                            children: [
                              Icon(
                                Icons.star_rounded,
                                color: Colors.white,
                                size: 20,
                              ),
                              Icon(
                                Icons.star_border_rounded,
                                color: Colors.black,
                                size: 20,
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
        Container(
          decoration: BoxDecoration(
              border: Border.all(width: 3),
              boxShadow: [shadow],
              borderRadius: BorderRadius.circular(99)),
          child: Assets.images.crow
              .image(height: 64, width: 64, fit: BoxFit.cover),
        ),
      ],
    );
  }
}
