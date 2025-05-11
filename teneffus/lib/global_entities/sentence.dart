import 'package:teneffus/global_entities/word.dart';

class Sentence {
  final String ar;
  final String tr;
  final List<Word> words;

  late final String id;

  Sentence({
    required this.ar,
    required this.tr,
    required this.words,
  }) {
    final combinedIds = words.map((w) => w.id).join('-');

    id = combinedIds.hashCode.toString();
  }
}
