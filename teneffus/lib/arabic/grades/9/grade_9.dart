import 'package:teneffus/global_entities/lesson.dart';
import 'package:teneffus/global_entities/unit.dart';
import 'package:teneffus/global_entities/word.dart';

class Grade9 {
  static List<Unit> grade9Units = [
    Unit(
        number: 1,
        nameTr: "Arapça Diline Giriş",
        nameAr: "مَدْخَلٌ إِلَى اللُّغَةِ العَرَبِيَّةِ",
        lessons: [
          Lesson(
              number: 1,
              nameAr: "الحروف والصوائت",
              nameTr: "Harfler ve Sesliler",
              words: []),
          Lesson(
              number: 2,
              nameAr: "أقرأ وأكتب",
              nameTr: "Okuyorum ve Yazıyorum",
              words: [
                Word(tr: "Erkek Öğrenci", ar: "طَالِبٌ"),
                Word(tr: "Kız Öğrenci", ar: "طالِبَةٌ"),
                Word(tr: "Öğretmen (Erkek)", ar: "مُعَلِّمٌ"),
                Word(tr: "Öğretmen (Kadın)", ar: "مُعَلِّمَةٌ"),
                Word(tr: "Okul", ar: "مَدْرَسَةٌ"),
                Word(tr: "Sınıf", ar: "صَفٌّ"),
                Word(tr: "Doktor (Erkek)", ar: "طَبِيبٌ"),
                Word(tr: "Doktor (Kadın)", ar: "طَبِيبَةٌ"),
              ]),
          Lesson(
              number: 3,
              nameAr: "التعارف والتعارف",
              nameTr: "Tanışma ve Tanıtma",
              words: [])
        ]),
    Unit(
        number: 2,
        nameTr: "Öğretmenim ve Arkadaşlarım",
        nameAr: "مُدَرِّسِي وأَصْدِقَائِي",
        lessons: [
          Lesson(nameAr: "مدرستي", nameTr: "Okulum", number: 1, words: []),
          Lesson(
              number: 2, nameAr: "أصدقائي", nameTr: "Arkadaşlarım", words: []),
          Lesson(number: 3, nameTr: "Dersim", nameAr: "درسي", words: [])
        ]),
    Unit(
        number: 3,
        nameTr: "Evim ve Ailem",
        nameAr: "بَيْتِي وأَسْرَتِي",
        lessons: [
          Lesson(
              nameAr: "مكونات البيت",
              nameTr: "Evin Bölümleri",
              number: 1,
              words: []),
          Lesson(
              number: 2,
              nameAr: "أفراد الأسرة",
              nameTr: "Aile Üyeleri",
              words: []),
          Lesson(number: 3, nameTr: "Mutfak", nameAr: "المطبخ", words: [])
        ]),
    Unit(
        number: 4,
        nameTr: "Günlük Hayatım",
        nameAr: "حَيَاتِي اليَوْمِيَّةُ",
        lessons: [
          Lesson(
              nameAr: "أنشطتي اليومية",
              nameTr: "Günlük Aktivitelerim",
              number: 1,
              words: []),
          Lesson(
              number: 2,
              nameAr: "أوقات الصلاة",
              nameTr: "Namaz Vakitleri",
              words: []),
          Lesson(number: 3, nameTr: "Bahçe", nameAr: "الحديقة", words: [])
        ]),
  ];
}
