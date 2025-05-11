class Word {
  String tr;
  String ar;
  String id;
  String audioUrl;
  String imagePath;

  Word({
    required this.tr,
    required this.ar,
  })  : id = '${tr.trim()}-${ar.trim()}'.hashCode.toString(),
        audioUrl = 'assets/sounds/${sanitizeFileName(tr.trim())}.mp3',
        imagePath = 'assets/images/${tr.trim()}.webp';

  @override
  String toString() {
    return 'Word{tr: $tr, ar: $ar}';
  }
}

String sanitizeFileName(String name) {
  name = name
      .replaceAll('ç', 'c')
      .replaceAll('ğ', 'g')
      .replaceAll('ı', 'i')
      .replaceAll('İ', 'I')
      .replaceAll('ş', 's')
      .replaceAll('ö', 'o')
      .replaceAll('ü', 'u')
      .replaceAll('Ç', 'C')
      .replaceAll('Ş', 'S')
      .replaceAll('Ö', 'O')
      .replaceAll('Ü', 'U')
      .replaceAll('Ğ', 'G');

  name = name.replaceAll(RegExp(r'[!() ]'), '');

  return name;
}
