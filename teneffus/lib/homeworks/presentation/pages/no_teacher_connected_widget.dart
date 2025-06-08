import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:teneffus/auth/presentation/auth_notifier.dart';
import 'package:teneffus/global_entities/snackbar_type.dart';
import 'package:teneffus/global_widgets/custom_snackbar.dart';
import 'package:teneffus/global_widgets/custom_text_button.dart';
import 'package:teneffus/global_widgets/custom_text_field.dart';
import 'package:teneffus/students/presentation/students_notifier.dart';
import 'package:teneffus/validator.dart';

class NoTeacherConnectedWidget extends HookConsumerWidget {
  const NoTeacherConnectedWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emailTextEditingController = useTextEditingController();
    final myInfo = ref.watch(authNotifierProvider.notifier).studentInformation;
    final studentsState = ref.watch(studentsNotifierProvider);
    final errorMessage = studentsState.value?.maybeWhen(
      error: (message) => Validator.validateErrorMessage(
        errorMessage: message,
      ),
      orElse: () => "Bilinmeyen bir hata oluştu.",
    );
    return Center(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(
          Icons.link_off_rounded,
          color: Colors.white,
          size: 64,
        ),
        const Gap(32),
        Text("Herhangi bir öğretmenin öğrenci listesinde yoksun.",
            textAlign: TextAlign.center,
            style: GoogleFonts.montserrat(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w800)),
        const Gap(16),
        Text("Öğretmeninin mail adresini gir.",
            style: GoogleFonts.montserrat(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w800)),
        const Gap(24),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: CustomTextField(controller: emailTextEditingController),
        ),
        const Gap(16),
        SizedBox(
            width: 160,
            child: CustomTextButton(
                text: "Tamam",
                onPressed: () async {
                  FocusScope.of(context).unfocus();
                  await Future.delayed(const Duration(milliseconds: 100));
                  final isSuccess = await ref
                      .read(studentsNotifierProvider.notifier)
                      .addStudent(myInfo!, emailTextEditingController.text);
                  if (isSuccess) {
                    CustomSnackbar.show(
                        type: SnackbarType.success(),
                        message: "Ekleme başarılı.",
                        context: context);
                    await ref
                        .read(authNotifierProvider.notifier)
                        .getStudentInformation();
                  } else {
                    CustomSnackbar.show(
                        type: SnackbarType.error(),
                        message: errorMessage ?? "",
                        context: context);
                  }
                }))
      ],
    ));
  }
}
