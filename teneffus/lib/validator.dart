import 'dart:collection';

class Validator {
  static HashMap errorMessages = HashMap.from({
    "invalid-credential":
        "Giriş bilgilerin hatalı. Hataları düzelt ve tekrar dene.",
    "wrong-password": "Şifre yanlış.",
    "weak-password": "Şifren çok kısa. En az 6 karakter uzunluğunda olmalı."
  });
  static String validateErrorMessage({required String errorMessage}) {
    if (errorMessages.containsKey(errorMessage)) {
      return errorMessages[errorMessage];
    } else {
      return "Bir sorun oluştu.";
    }
  }
}
