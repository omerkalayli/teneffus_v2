import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:teneffus/constants.dart';
import 'package:teneffus/global_entities/button_type.dart';
import 'package:teneffus/global_widgets/custom_button.dart';

class MainUnitButton extends StatelessWidget {
  const MainUnitButton({
    required this.onTapped,
    required this.unitName,
    required this.unitNumber,
    required this.lessonName,
    super.key,
  });

  final Function() onTapped;
  final String unitName;
  final int unitNumber;
  final String lessonName;

  @override
  Widget build(BuildContext context) {
    Color textColor = Colors.white.withValues(alpha: 0.8);

    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.topCenter,
      children: [
        IntrinsicWidth(
          child: ConstrainedBox(
            constraints: const BoxConstraints(minWidth: 200),
            child: CustomButton(
                borderColor: Colors.black45,
                isSticky: true,
                value: false,
                buttonStrokeBorderRadius: BorderRadius.circular(99),
                buttonOnPressedShadowBorderRadius: BorderRadius.circular(99),
                buttonBackgroundAndForegroundBorderRadius:
                    BorderRadius.circular(99),
                buttonPalette: ButtonPalette.darkCyan(),
                child: Container(
                  padding: const EdgeInsets.only(top: 2, right: 8, left: 8),
                  child: Center(
                    child: Column(
                      children: [
                        Text(
                          unitName,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: textColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w600),
                        ),
                        const Gap(2),
                        Text(
                          lessonName,
                          style: TextStyle(
                              color: textColor,
                              fontSize: 10,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                ),
                onPressed: () {
                  onTapped();
                }),
          ),
        ),
        Positioned(
          top: -14,
          child: InkWell(
            overlayColor: const WidgetStatePropertyAll(Colors.transparent),
            onTap: onTapped,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black45, width: 2),
                  color: buttonForegroundColorDarkCyan,
                  borderRadius: BorderRadius.circular(99)),
              child: Text(
                unitNumber == -1
                    ? "Tüm Üniteler"
                    : "Ünite ${(unitNumber + 1).toString()}",
                style: TextStyle(color: textColor, fontSize: 10),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
