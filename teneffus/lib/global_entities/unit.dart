import 'package:teneffus/global_entities/lesson.dart';

class Unit {
  List<Lesson> lessons;
  String nameTr;
  String nameAr;
  int number;

  Unit({
    required this.lessons,
    required this.nameTr,
    required this.nameAr,
    required this.number,
  });
}
