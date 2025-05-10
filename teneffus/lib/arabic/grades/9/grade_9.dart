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
              nameAr: "ٱلْحُرُوفُ وَٱلصَّوَائِتُ",
              nameTr: "Harfler ve Sesliler",
              words: []),
          Lesson(
              number: 2,
              nameAr: "أَقْرَأُ وَأَكْتُبُ",
              nameTr: "Okuyorum ve Yazıyorum",
              words: [
                Word(tr: "Erkek Öğrenci", ar: "طَالِبٌ"),
                Word(tr: "Kız Öğrenci", ar: "طَالِبَةٌ"),
                Word(tr: "Öğretmen (Erkek)", ar: "مُعَلِّمٌ"),
                Word(tr: "Öğretmen (Kadın)", ar: "مُعَلِّمَةٌ"),
                Word(tr: "Okul", ar: "مَدْرَسَةٌ"),
                Word(tr: "Sınıf", ar: "صَفٌّ"),
                Word(tr: "Doktor (Erkek)", ar: "طَبِيبٌ"),
                Word(tr: "Doktor (Kadın)", ar: "طَبِيبَةٌ"),
                Word(tr: "Gel! (Erkeğe)", ar: "تَعَالَ"),
                Word(tr: "Gel! (Kadına)", ar: "تَعَالَيْ"),
                Word(tr: "Oku! (Erkeğe)", ar: "اِقْرَأْ"),
                Word(tr: "Oku! (Kadına)", ar: "اِقْرَئِي"),
                Word(tr: "Otur! (Erkeğe)", ar: "اِجْلِسْ"),
                Word(tr: "Otur! (Kadına)", ar: "اِجْلِسِي"),
                Word(tr: "Kalk! (Erkeğe)", ar: "قُمْ"),
                Word(tr: "Kalk! (Kadına)", ar: "قُومِي"),
                Word(tr: "Kapat! (Erkeğe)", ar: "أَغْلِقْ"),
                Word(tr: "Kapat! (Kadına)", ar: "أَغْلِقِي"),
                Word(tr: "Yaz! (Erkeğe)", ar: "اُكْتُبْ"),
                Word(tr: "Yaz! (Kadına)", ar: "اُكْتُبِي"),
              ]),
          Lesson(
              number: 3,
              nameAr: "ٱلتَّعَارُفُ وَٱلتَّقَدُّمُ",
              nameTr: "Tanışma ve Tanıtma",
              words: [])
        ]),
    Unit(
        number: 2,
        nameTr: "Öğretmenim ve Arkadaşlarım",
        nameAr: "مُدَرِّسِي وَأَصْدِقَائِي",
        lessons: [
          Lesson(nameAr: "مَدْرَسَتِي", nameTr: "Okulum", number: 1, words: []),
          Lesson(
              number: 2,
              nameAr: "أَصْدِقَائِي",
              nameTr: "Arkadaşlarım",
              words: []),
          Lesson(number: 3, nameTr: "Dersim", nameAr: "دَرْسِي", words: [])
        ]),
    Unit(
        number: 3,
        nameTr: "Evim ve Ailem",
        nameAr: "بَيْتِي وَأُسْرَتِي",
        lessons: [
          Lesson(
              nameAr: "مُكَوِّنَاتُ ٱلْبَيْتِ",
              nameTr: "Evin Bölümleri",
              number: 1,
              words: []),
          Lesson(
              number: 2,
              nameAr: "أَفْرَادُ ٱلْأُسْرَةِ",
              nameTr: "Aile Üyeleri",
              words: []),
          Lesson(number: 3, nameTr: "Mutfak", nameAr: "ٱلْمَطْبَخُ", words: [])
        ]),
    Unit(
        number: 4,
        nameTr: "Günlük Hayatım",
        nameAr: "حَيَاتِي ٱلْيَوْمِيَّةُ",
        lessons: [
          Lesson(
              nameAr: "أَنْشِطَتِي ٱلْيَوْمِيَّةُ",
              nameTr: "Günlük Aktivitelerim",
              number: 1,
              words: []),
          Lesson(
              number: 2,
              nameAr: "أَوْقَاتُ ٱلصَّلَاةِ",
              nameTr: "Namaz Vakitleri",
              words: []),
          Lesson(number: 3, nameTr: "Bahçe", nameAr: "ٱلْحَدِيقَةُ", words: [])
        ]),
  ];
}
