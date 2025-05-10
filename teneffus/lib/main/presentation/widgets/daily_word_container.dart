import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:teneffus/gen/assets.gen.dart';
import 'package:teneffus/global_entities/button_type.dart';
import 'package:teneffus/global_widgets/custom_text_button.dart';

/// This widget is used to display the daily word container.

class DailyWordContainer extends StatelessWidget {
  const DailyWordContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      clipBehavior: Clip.none,
      children: [
        Container(
          margin: const EdgeInsets.only(left: 16, right: 16, top: 16),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(width: 2, color: Colors.white),
              gradient: const LinearGradient(
                  colors: [Color(0xff38ACEA), Color(0xff4C91E2)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter)),
          child: Row(
            children: [
              Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.bottomCenter,
                children: [
                  CustomTextButton(
                    fontSize: 12,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    buttonPalette: ButtonPalette.green(),
                    onPressed: () {},
                    text: "Öğren",
                  ),
                  Positioned(
                    bottom: -8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.4),
                              blurRadius: 4,
                              offset: const Offset(0, 4),
                            ),
                          ],
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(8)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("2", style: TextStyle(fontSize: 10)),
                          Padding(
                            padding: const EdgeInsets.only(top: 1.0),
                            child: Assets.images.yellowStar.image(
                              width: 12,
                              height: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              const Spacer(),
              const Text("ما هذا؟"),
              const Gap(8),
              Container(
                width: 100,
                height: 64,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8), color: Colors.grey),
              )
            ],
          ),
        ),
        Positioned(
          top: 0,
          child: IntrinsicWidth(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                  color: const Color(0xff38ACEA),
                  borderRadius: const BorderRadius.all(Radius.circular(4)),
                  border: Border.all(color: Colors.white, width: 2)),
              child: const Center(
                child: Text("Günün Kelimesi"),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
