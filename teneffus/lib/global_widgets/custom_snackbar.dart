import 'package:flutter/material.dart';
import 'package:teneffus/constants.dart';
import 'package:teneffus/global_entities/snackbar_type.dart';

class CustomSnackbar {
  static void show(
      {required SnackbarType type,
      required String message,
      required BuildContext context}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: type.when(
            success: () => snackbarSuccessColor,
            error: () => snackbarErrorColor,
            info: () => snackbarInfoColor),
      ),
    );
  }
}
