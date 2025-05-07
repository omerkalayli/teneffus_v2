import 'package:teneffus/global_entities/word.dart';

class Lesson {
  int number;
  String nameTr;
  String nameAr;
  List<Word> words;

  Lesson({
    required this.number,
    required this.nameTr,
    required this.nameAr,
    required this.words,
  });
}
