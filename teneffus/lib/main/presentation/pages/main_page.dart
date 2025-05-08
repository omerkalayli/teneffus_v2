import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:teneffus/auth/presentation/auth_notifier.dart';
import 'package:teneffus/global_entities/button_type.dart';
import 'package:teneffus/global_widgets/custom_text_button.dart';
import 'package:teneffus/main/presentation/widgets/daily_container.dart';
import 'package:teneffus/main/presentation/widgets/daily_word_container.dart';
import 'package:teneffus/main/presentation/widgets/main_header.dart';

/// [MainPage], is the main page of the application.

class MainPage extends HookConsumerWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userInfo = ref.watch(authNotifierProvider.notifier).userInformation;
    const dayStreak = 6;
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(bottom: 100),
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
                              text: "Quize Başla", onPressed: () {}),
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
              )
            ],
          ),
        ),
      ),
    );
  }
}

class MainUnitButton extends StatelessWidget {
  const MainUnitButton({
    required this.onTapped,
    required this.unitName,
    required this.unitNumber,
    super.key,
  });

  final Function() onTapped;
  final String unitName;
  final int unitNumber;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.topCenter,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.25),
          child: InkWell(
            onTap: () {
              onTapped();
            },
            child: CustomTextButton(
                isSticky: true,
                value: false,
                fontSize: 12,
                textStyle: const TextStyle(
                    color: Colors.black,
                    fontSize: 10,
                    fontWeight: FontWeight.w600),
                buttonStrokeBorderRadius: BorderRadius.circular(99),
                buttonOnPressedShadowBorderRadius: BorderRadius.circular(99),
                buttonBackgroundAndForegroundBorderRadius:
                    BorderRadius.circular(99),
                buttonPalette: ButtonPalette.yellow(),
                text: unitName,
                onPressed: () {}),
          ),
        ),
        Positioned(
          top: -14,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 2),
                color: Colors.yellow,
                borderRadius: BorderRadius.circular(99)),
            child: Text(
              "Ünite ${unitNumber.toString()}",
              style: const TextStyle(color: Colors.black, fontSize: 10),
            ),
          ),
        ),
      ],
    );
  }
}
