import 'package:email_validator/email_validator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:teneffus/auth/presentation/auth_notifier.dart';
import 'package:teneffus/auth/presentation/pages/auth_page.dart';
import 'package:teneffus/auth/presentation/widgets/register_container.dart';
import 'package:teneffus/constants.dart';
import 'package:teneffus/gen/assets.gen.dart';
import 'package:teneffus/global_entities/button_type.dart';
import 'package:teneffus/global_entities/snackbar_type.dart';
import 'package:teneffus/global_widgets/custom_button.dart';
import 'package:teneffus/global_widgets/custom_snackbar.dart';
import 'package:teneffus/global_widgets/custom_text_button.dart';
import 'package:teneffus/global_widgets/custom_text_field.dart';
import 'package:teneffus/global_widgets/stroked_text.dart';
import 'package:teneffus/validator.dart';

/// [AuthLoginPage] is the page where users can login to the app.
class AuthLoginPage extends HookConsumerWidget {
  const AuthLoginPage({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emailTextEditingController = useTextEditingController(
        text: kDebugMode ? "omerkalayli.4@gmail.com" : "");
    final passwordTextEditingController = useTextEditingController();
    double textFieldHeight = 48;
    double iconButtonSize = 48;
    final isStudent = ref.watch(userTypeProvider);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.transparent,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Center(
                  child: Text(
                    "Sarfia'ya giriş yap.",
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall?.copyWith(color: Colors.white)
                        ,
                  ),
                ),
                const Gap(16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 12.0, bottom: 4),
                      child: Text(
                        "Mail Adresi",
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white  )                      
                      ),
                    ),
                    CustomTextField(
                      controller: emailTextEditingController,
                    ),
                    const Gap(16),
                    Padding(
                      padding: const EdgeInsets.only(left: 12.0, bottom: 4),
                      child: Text(
                        "Şifre",
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white  )
                      ),
                    ),
                    SizedBox(
                        height: textFieldHeight,
                        child: CustomTextField(
                          obscureText: true,
                          controller: passwordTextEditingController,
                        )),
                    const Gap(4),
                    Align(
                      alignment: Alignment.centerRight,
                      child: InkWell(
                        onTap: () async {
                          bool isValid = EmailValidator.validate(
                              emailTextEditingController.text);

                          if (!isValid) {
                            CustomSnackbar.show(
                                type: SnackbarType.error(),
                                message: "Bu mail adresi geçerli değil.",
                                context: context);
                          } else {
                            var res = await ref
                                .read(authNotifierProvider.notifier)
                                .sendResetPasswordEmail(
                                    email: emailTextEditingController.text);

                            res.fold(
                                (l) => CustomSnackbar.show(
                                    context: context,
                                    message: Validator.validateErrorMessage(
                                        errorMessage: l.message),
                                    type: SnackbarType.error()),
                                (r) => CustomSnackbar.show(
                                    context: context,
                                    message:
                                        "Şifre sıfırlama mailini gönderdik. Şifreni maildeki link üzerinden sıfırlayabilirsin.",
                                    type: SnackbarType.success()));
                          }
                        },
                        child: const Padding(
                          padding: EdgeInsets.only(right: 4, top: 4),
                          child: IntrinsicWidth(
                            child: Text(
                              maxLines: 1,
                                style: TextStyle(
                                  color: Colors.white,
                                    decoration: TextDecoration.underline,
                                    decorationColor: Colors.white,
                                    decorationThickness: 2),
                                "Şifremi unuttum!"),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const Gap(32),
                SizedBox(
                  height: 36,
                  width: 200,
                  child: CustomTextButton(
                    buttonPalette: ButtonPalette.deepOrange(),
                    text: "Giriş Yap",
                    onPressed: () async {
                      await _signInWithEmail(
                          emailTextEditingController:
                              emailTextEditingController,
                          passwordTextEditingController:
                              passwordTextEditingController,
                          context: context,
                          ref: ref,
                          isStudent: isStudent);
                    },
                  ),
                ),
                const Gap(16),
                Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 1.4,
                            width: double.maxFinite,
                            color: Colors.white,
                          ),
                        ),
                        const Gap(8),
                        const Text("Diğer Giriş Seçenekleri", style: TextStyle(color: Colors.white),),
                        const Gap(8),
                        Expanded(
                          child: Container(
                            height: 1.4,
                            width: double.maxFinite,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    const Gap(16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: iconButtonSize,
                          width: iconButtonSize,
                          child: CustomButton(
                            buttonPalette: ButtonPalette.white(),
                            onPressed: () {},
                            child: Icon(
                              Icons.apple,
                              size: iconButtonSize - 16,
                            ),
                          ),
                        ),
                        const Gap(24),
                        SizedBox(
                          height: iconButtonSize,
                          width: iconButtonSize,
                          child: CustomButton(
                            buttonPalette: ButtonPalette.white(),
                            onPressed: () async {
                              await ref
                                  .read(authNotifierProvider.notifier)
                                  .signInWithGoogle();
                            },
                            child: Assets.images.google.image(
                                width: iconButtonSize * .46,
                                height: iconButtonSize * .46),
                          ),
                        ),
                      ],
                    ),
                    const Gap(32),
                    RegisterContainer(
                      onTap: () async {
                        await ref
                            .read(carouselControllerProvider)
                            .nextPage(curve: Curves.fastEaseInToSlowEaseOut);
                        if (context.mounted) {
                          await ref
                              .read(authNotifierProvider.notifier)
                              .redirectToRegister();
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _signInWithEmail(
      {required TextEditingController emailTextEditingController,
      required TextEditingController passwordTextEditingController,
      required BuildContext context,
      required WidgetRef ref,
      required bool isStudent}) async {
    bool isValid = EmailValidator.validate(emailTextEditingController.text);
    if (emailTextEditingController.text.isEmpty) {
      CustomSnackbar.show(
          type: SnackbarType.error(),
          message: "Mail adresini girmelisin.",
          context: context);
    } else if (passwordTextEditingController.text.isEmpty) {
      CustomSnackbar.show(
          type: SnackbarType.error(),
          message: "Şifreni girmelisin.",
          context: context);
    } else if (isValid) {
      await ref.read(authNotifierProvider.notifier).signInWithEmail(
            email: emailTextEditingController.text,
            password: passwordTextEditingController.text,
          );
    } else {
      CustomSnackbar.show(
          type: SnackbarType.error(),
          message: "Bu mail adresi geçerli değil.",
          context: context);
    }
  }
}
