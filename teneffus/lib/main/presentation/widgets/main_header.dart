import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:teneffus/auth/domain/entities/user_information.dart';
import 'package:teneffus/auth/presentation/auth_notifier.dart';
import 'package:teneffus/global_widgets/stroked_text.dart';
import 'package:teneffus/main/presentation/widgets/user_badge.dart';

/// This widget is used to display the main header of the app.
/// It shows the user's name, surname, and a settings icon.

class MainHeader extends HookConsumerWidget {
  const MainHeader({
    super.key,
    required this.userInfo,
  });

  final UserInformation? userInfo;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: StrokedText(
                    style: TextStyle(fontSize: 16, shadows: [
                      Shadow(
                          blurRadius: 16,
                          offset: const Offset(0, 4),
                          color: Colors.black.withValues(alpha: .25)),
                    ]),
                    strokeWidth: 2,
                    "${userInfo?.name} ${userInfo?.surname}"),
              ),
              const Gap(4),
              const UserBadge()
            ],
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
      ),
    );
  }
}
