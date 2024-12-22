import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:teneffus/constants.dart';
import 'package:teneffus/global_widgets/custom_picker.dart';
import 'package:teneffus/global_widgets/custom_text_button.dart';
import 'package:teneffus/global_widgets/custom_text_field.dart';
import 'package:teneffus/global_widgets/stroked_text.dart';

class AuthRegisterPage extends StatelessWidget {
  const AuthRegisterPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Center(
              child: StrokedText(
                "Seni tanıyalım.",
                strokeWidth: 2.5,
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall!
                    .copyWith(shadows: [textShadowSmall]),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 4.0),
                  child: StrokedText(
                    "Adın",
                    strokeWidth: 2,
                    strokeColor: const Color(0xff4A4A4A),
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      shadows: [textShadowSmall],
                    ),
                  ),
                ),
                SizedBox(height: 60, child: CustomTextField()),
                const Gap(32),
                Padding(
                  padding: const EdgeInsets.only(left: 4.0),
                  child: StrokedText(
                    "Soyadın",
                    strokeWidth: 2,
                    strokeColor: const Color(0xff4A4A4A),
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      shadows: [textShadowSmall],
                    ),
                  ),
                ),
                SizedBox(height: 60, child: CustomTextField()),
                const Gap(32),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 4.0),
                    child: StrokedText(
                      "Sınıfın",
                      strokeWidth: 2,
                      strokeColor: const Color(0xff4A4A4A),
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        shadows: [textShadowSmall],
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.white60, width: 3),
                        color: Colors.transparent),
                    child: CustomPicker(
                      labels: const ["9", "10", "11", "12"],
                      onSelected: (index) {
                        print(index);
                      },
                      defaultIndex: 3,
                    ),
                  ),
                ),
              ],
            ),
            const Gap(4),
            SizedBox(
              height: 60,
              width: 200,
              child: CustomTextButton(
                text: "Giriş Yap",
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
