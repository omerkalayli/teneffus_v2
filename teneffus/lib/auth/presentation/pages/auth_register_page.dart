import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:teneffus/auth/presentation/auth_notifier.dart';
import 'package:teneffus/auth/presentation/pages/auth_login_page.dart';
import 'package:teneffus/auth/presentation/widgets/user_type_selection_container.dart';
import 'package:teneffus/constants.dart';
import 'package:teneffus/global_entities/button_type.dart';
import 'package:teneffus/global_entities/snackbar_type.dart';
import 'package:teneffus/global_widgets/custom_picker.dart';
import 'package:teneffus/global_widgets/custom_snackbar.dart';
import 'package:teneffus/global_widgets/custom_text_button.dart';
import 'package:teneffus/global_widgets/custom_text_field.dart';
import 'package:teneffus/global_widgets/stroked_text.dart';

class AuthRegisterPage extends HookConsumerWidget {
  const AuthRegisterPage({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nameTextEditingController = useTextEditingController();
    final surnameTextEditingController = useTextEditingController();
    final emailTextEditingController = useTextEditingController(
        text: kDebugMode ? "omerkalayli.4@gmail.com" : "");
    final passwordTextEditingController = useTextEditingController();
    final grade = useState(9);
    final auth = FirebaseAuth.instance;

    bool signedInWithGoogle = auth.currentUser != null;

    final isStudent = useState(true);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.transparent,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Center(
                  child: Text(
                    signedInWithGoogle
                        ? "Seni tanıyalım."
                        : "Sarfia'ya kaydol.",
                style: Theme.of(context)
                        .textTheme
                        .headlineSmall?.copyWith(color: Colors.white))
                ),
                const Gap(16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (!signedInWithGoogle) ...[
                      UserTypeSelectionContainer(
                          isStudent: isStudent.value,
                          onStudentSelected: () {
                            isStudent.value = true;
                          },
                          onTeacherSelected: () {
                            isStudent.value = false;
                          }),
                      const Gap(16),
                      Padding(
                        padding: const EdgeInsets.only(left: 12.0, bottom: 4),
                        child: Text(
                          "Mail Adresi",
                          style:
                              Theme.of(context).textTheme.bodyMedium
                        ),
                      ),
                      CustomTextField(
                        controller: emailTextEditingController,
                      ),
                      const Gap(8),
                      Padding(
                        padding: const EdgeInsets.only(left: 12.0, bottom: 4),
                        child: Text(
                          "Şifre",
                          style:
                              Theme.of(context).textTheme.bodyMedium
                        ),
                      ),
                      CustomTextField(
                        obscureText: true,
                        controller: passwordTextEditingController,
                      ),
                    ],
                    const Gap(8),
                    Padding(
                      padding: const EdgeInsets.only(left: 12.0, bottom: 4),
                      child: Text(
                        "Adın",
                        style: Theme.of(context).textTheme.bodyMedium
                      ),
                    ),
                    CustomTextField(
                      controller: nameTextEditingController,
                    ),
                    const Gap(8),
                    Padding(
                      padding: const EdgeInsets.only(left: 12.0, bottom: 4),
                      child: Text(
                        "Soyadın",
                        style: Theme.of(context).textTheme.bodyMedium
                      ),
                    ),
                    CustomTextField(
                      controller: surnameTextEditingController,
                    ),
                    const Gap(8),
                    !(isStudent.value)
                        ? const SizedBox.shrink()
                        : Column(
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 12.0, bottom: 4),
                                  child: Text(
                                    "Sınıfın",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Container(
                                  padding: const EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16),
                                      border: Border.all(
                                          color: Colors.white, width: 2),
                                      color: Colors.transparent),
                                  child: CustomPicker(
                                    labels: const ["9", "10", "11", "12"],
                                    onSelected: (index) {
                                      grade.value = index + 9;
                                    },
                                    defaultIndex: 0,
                                  ),
                                ),
                              ),
                            ],
                          ),
                  ],
                ),
                Gap(signedInWithGoogle ? 48 : 32),
                SizedBox(
                  height: 36,
                  width: 200,
                  child: CustomTextButton(
                    buttonPalette: ButtonPalette.midnightBlue(),
                    text: "Hesap Oluştur",
                    onPressed: () async {
                      if (nameTextEditingController.text.isEmpty ||
                          surnameTextEditingController.text.isEmpty ||
                          (passwordTextEditingController.text.isEmpty &&
                              !signedInWithGoogle)) {
                        CustomSnackbar.show(
                          context: context,
                          message: "Lütfen tüm alanları doldurun.",
                          type: SnackbarType.error(),
                        );
                        return;
                      }
                      if (isStudent.value) {
                        await ref
                            .read(authNotifierProvider.notifier)
                            .registerStudent(
                              name: nameTextEditingController.text,
                              surname: surnameTextEditingController.text,
                              grade: grade.value,
                              email: emailTextEditingController.text,
                              password: passwordTextEditingController.text,
                            );
                      } else {
                        await ref
                            .read(authNotifierProvider.notifier)
                            .registerTeacher(
                              name: nameTextEditingController.text,
                              surname: surnameTextEditingController.text,
                              email: emailTextEditingController.text,
                              password: passwordTextEditingController.text,
                            );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
