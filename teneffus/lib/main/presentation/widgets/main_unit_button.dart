import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:teneffus/constants.dart';

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
    Color textColor = Colors.white;

    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.topCenter,
      children: [
        IntrinsicWidth(
          child: ConstrainedBox(
            constraints: const BoxConstraints(minWidth: 200),
            child: InkWell(
              overlayColor: const WidgetStatePropertyAll(Colors.transparent),
              onTap: () {
                onTapped();
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  color: buttonForegroundColorBlue,
                  border: Border.all(
                    color: Colors.black,
                    width: 1,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: .3),
                      blurRadius: 2,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                padding:
                    const EdgeInsets.only(top: 6, right: 8, left: 8, bottom: 6),
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
            ),
          ),
        ),
        if (unitNumber != -1)
          Positioned(
            top: -14,
            child: InkWell(
              overlayColor: const WidgetStatePropertyAll(Colors.transparent),
              onTap: onTapped,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black26, width: 1),
                    color: buttonForegroundColorBlue,
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
