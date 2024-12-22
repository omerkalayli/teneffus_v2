import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:teneffus/constants.dart';
import 'package:teneffus/gen/assets.gen.dart';
import 'package:teneffus/global_entities/button_type.dart';
import 'package:teneffus/global_widgets/custom_button.dart';
import 'package:teneffus/global_widgets/custom_text_button.dart';
import 'package:teneffus/global_widgets/custom_text_field.dart';
import 'package:teneffus/global_widgets/stroked_text.dart';

/// [AuthLoginPage] is the page where users can login to the app.

class AuthLoginPage extends StatelessWidget {
  const AuthLoginPage({
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
                "Teneffüs'e giriş yap.",
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
                    "Mail Adresi",
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
                    "Şifre",
                    strokeWidth: 2,
                    strokeColor: const Color(0xff4A4A4A),
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      shadows: [textShadowSmall],
                    ),
                  ),
                ),
                SizedBox(height: 60, child: CustomTextField()),
                const Gap(4),
                InkWell(
                  onTap: () {},
                  child: const Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              decorationColor: Colors.white,
                              decorationThickness: 2),
                          "Şifremi unuttum!")),
                ),
              ],
            ),
            SizedBox(
              height: 60,
              width: 200,
              child: CustomTextButton(
                text: "Giriş Yap",
                onPressed: () {},
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 1,
                    width: double.maxFinite,
                    color: Colors.black,
                  ),
                ),
                const Gap(8),
                const StrokedText("Diğer Giriş Seçenekleri", strokeWidth: 1.5),
                const Gap(8),
                Expanded(
                  child: Container(
                    height: 1,
                    width: double.maxFinite,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 60,
                  width: 60,
                  child: CustomButton(
                    buttonPalette: ButtonPalette.white(),
                    onPressed: () {},
                    child: const Icon(
                      Icons.apple,
                      size: 40,
                    ),
                  ),
                ),
                const Gap(24),
                SizedBox(
                  height: 60,
                  width: 60,
                  child: CustomButton(
                    buttonPalette: ButtonPalette.white(),
                    onPressed: () {},
                    child: Assets.images.google.image(width: 32, height: 32),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
