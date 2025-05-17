import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:teneffus/auth/presentation/auth_notifier.dart';
import 'package:teneffus/global_entities/button_type.dart';
import 'package:teneffus/global_widgets/custom_text_button.dart';
import 'package:teneffus/main/presentation/widgets/daily_container.dart';
import 'package:teneffus/main/presentation/widgets/daily_word_container.dart';
import 'package:teneffus/main/presentation/widgets/main_header.dart';
import 'package:teneffus/main/presentation/widgets/main_unit_button.dart';

/// [MainPage], is the main page of the application.

class MainPage extends HookConsumerWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userInfo = ref.watch(authNotifierProvider.notifier).userInformation;
    const dayStreak = 6;
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            MainHeader(userInfo: userInfo),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const DailyContainer(dayStreak: dayStreak),
                  const DailyWordContainer(),
                  Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal:
                                MediaQuery.of(context).size.width * 0.2),
                        child: CustomTextButton(
                            buttonPalette: ButtonPalette.darkCyan(),
                            textStyle:
                                TextStyle(fontSize: 16, color: Colors.white),
                            text: "Quize Başla",
                            onPressed: () {}),
                      ),
                      Container(
                        width: 2,
                        height: 40,
                        color: Colors.black,
                      ),
                      MainUnitButton(
                        onTapped: () {},
                        unitName: "Okulum ve Arkadaşlarım",
                        unitNumber: 9,
                      ),
                    ],
                  )
                ],
              ),
            ),
            Gap(144)
          ],
        ),
      ),
    );
  }
}
