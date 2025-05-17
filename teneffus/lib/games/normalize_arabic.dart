String normalizeArabic(String input) {
  // Harekeleri kaldır
  final diacritics = RegExp(r'[\u064B-\u065F\u0670]');

  String result = input.replaceAll(diacritics, '');
  result = result.replaceAll(RegExp(r'[أإآ]'), 'ا');
  if (result.endsWith('ة')) {
    result = result.substring(0, result.length - 1) + 'ه';
  }
  return result;
}
