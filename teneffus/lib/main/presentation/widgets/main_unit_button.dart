import 'package:flutter/material.dart';
import 'package:teneffus/global_entities/button_type.dart';
import 'package:teneffus/global_widgets/custom_text_button.dart';

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
