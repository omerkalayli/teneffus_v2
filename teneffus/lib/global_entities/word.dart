class Word {
  String tr;
  String ar;
  String id;

  Word({
    required this.tr,
    required this.ar,
  }) : id = '${tr.trim()}-${ar.trim()}'.hashCode.toString();

  @override
  String toString() {
    return 'Word{tr: $tr, ar: $ar}';
  }
}
