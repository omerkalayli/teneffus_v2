class Validator {
  static final Map<String, String> errorMessages = {
    "invalid-credential":
        "Giriş bilgilerin hatalı. Hataları düzelt ve tekrar dene.",
    "wrong-password": "Şifre yanlış.",
    "weak-password": "Şifren çok kısa. En az 6 karakter uzunluğunda olmalı.",
    "email-already-in-use": "Bu e-posta adresi zaten kullanılıyor.",
    "no-teacher": "Bu mail adresine sahip bir öğretmen bulunamadı.",
    "wrong-user-type": "Kullanıcı tipi hatalı.",
  };
  static String validateErrorMessage({required String errorMessage}) {
    if (errorMessages.containsKey(errorMessage)) {
      return errorMessages[errorMessage] ?? "Bir sorun oluştu.";
    } else {
      return "Bir sorun oluştu.";
    }
  }
}
