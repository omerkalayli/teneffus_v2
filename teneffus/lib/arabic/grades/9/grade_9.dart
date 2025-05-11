import 'package:teneffus/global_entities/lesson.dart';
import 'package:teneffus/global_entities/sentence.dart';
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
            ],
            sentences: [
              Sentence(
                  ar: "أَنَا طَالِبٌ",
                  tr: "Ben bir erkek öğrenciyim.",
                  words: [
                    Word(tr: "Ben", ar: "أَنَا"),
                    Word(tr: "Erkek Öğrenci", ar: "طَالِبٌ")
                  ]),
              Sentence(
                  ar: "أَنَا طَالِبَةٌ",
                  tr: "Ben bir kız öğrenciyim.",
                  words: [
                    Word(tr: "Ben", ar: "أَنَا"),
                    Word(tr: "Kız Öğrenci", ar: "طَالِبَةٌ")
                  ]),
              Sentence(
                  ar: "هُوَ مُعَلِّمٌ",
                  tr: "O bir erkek öğretmendir.",
                  words: [
                    Word(tr: "O (erkek)", ar: "هُوَ"),
                    Word(tr: "Öğretmen (Erkek)", ar: "مُعَلِّمٌ")
                  ]),
              Sentence(
                  ar: "هِيَ مُعَلِّمَةٌ",
                  tr: "O bir kadın öğretmendir.",
                  words: [
                    Word(tr: "O (kadın)", ar: "هِيَ"),
                    Word(tr: "Öğretmen (Kadın)", ar: "مُعَلِّمَةٌ")
                  ]),
              Sentence(ar: "مَنْ هُوَ؟", tr: "O kimdir?", words: [
                Word(tr: "Kim", ar: "مَنْ"),
                Word(tr: "O (erkek)", ar: "هُوَ")
              ]),
              Sentence(ar: "مَنْ هِيَ؟", tr: "O kimdir?", words: [
                Word(tr: "Kim", ar: "مَنْ"),
                Word(tr: "O (kadın)", ar: "هِيَ")
              ]),
              Sentence(
                  ar: "تَعَالَ إِلَى الصَّفِّ",
                  tr: "Sınıfa gel! (Erkeğe)",
                  words: [
                    Word(tr: "Gel! (Erkeğe)", ar: "تَعَالَ"),
                    Word(tr: "-e doğru", ar: "إِلَى"),
                    Word(tr: "Sınıf", ar: "صَفٌّ")
                  ]),
              Sentence(
                  ar: "تَعَالَيْ إِلَى الْمَدْرَسَةِ",
                  tr: "Okula gel! (Kadına)",
                  words: [
                    Word(tr: "Gel! (Kadına)", ar: "تَعَالَيْ"),
                    Word(tr: "-e doğru", ar: "إِلَى"),
                    Word(tr: "Okul", ar: "مَدْرَسَةٌ")
                  ]),
              Sentence(
                  ar: "اِقْرَأْ يَا طَالِبُ",
                  tr: "Oku ey erkek öğrenci!",
                  words: [
                    Word(tr: "Oku! (Erkeğe)", ar: "اِقْرَأْ"),
                    Word(tr: "Ya", ar: "يَا"),
                    Word(tr: "Erkek Öğrenci", ar: "طَالِبٌ")
                  ]),
              Sentence(
                  ar: "اِقْرَئِي يَا طَالِبَةُ",
                  tr: "Oku ey kız öğrenci!",
                  words: [
                    Word(tr: "Oku! (Kadına)", ar: "اِقْرَئِي"),
                    Word(tr: "Ya", ar: "يَا"),
                    Word(tr: "Kız Öğrenci", ar: "طَالِبَةٌ")
                  ]),
              Sentence(
                  ar: "اِجْلِسْ يَا طَبِيبُ",
                  tr: "Otur ey doktor! (Erkeğe)",
                  words: [
                    Word(tr: "Otur! (Erkeğe)", ar: "اِجْلِسْ"),
                    Word(tr: "Ya", ar: "يَا"),
                    Word(tr: "Doktor (Erkek)", ar: "طَبِيبٌ")
                  ]),
              Sentence(
                  ar: "اِجْلِسِي يَا طَبِيبَةُ",
                  tr: "Otur ey doktor! (Kadına)",
                  words: [
                    Word(tr: "Otur! (Kadına)", ar: "اِجْلِسِي"),
                    Word(tr: "Ya", ar: "يَا"),
                    Word(tr: "Doktor (Kadın)", ar: "طَبِيبَةٌ")
                  ]),
              Sentence(
                  ar: "قُمْ إِلَى الْمُعَلِّمِ",
                  tr: "Öğretmenin yanına kalk! (Erkeğe)",
                  words: [
                    Word(tr: "Kalk! (Erkeğe)", ar: "قُمْ"),
                    Word(tr: "-e doğru", ar: "إِلَى"),
                    Word(tr: "Öğretmen (Erkek)", ar: "مُعَلِّمٌ")
                  ]),
              Sentence(
                  ar: "قُومِي إِلَى الْمُعَلِّمَةِ",
                  tr: "Öğretmenin yanına kalk! (Kadına)",
                  words: [
                    Word(tr: "Kalk! (Kadına)", ar: "قُومِي"),
                    Word(tr: "-e doğru", ar: "إِلَى"),
                    Word(tr: "Öğretmen (Kadın)", ar: "مُعَلِّمَةٌ")
                  ]),
              Sentence(
                  ar: "أَغْلِقْ الْكِتَابَ",
                  tr: "Kitabı kapa! (Erkeğe)",
                  words: [
                    Word(tr: "Kapat! (Erkeğe)", ar: "أَغْلِقْ"),
                  ]),
              Sentence(
                  ar: "أَغْلِقِي الْكِتَابَ",
                  tr: "Kitabı kapa! (Kadına)",
                  words: [
                    Word(tr: "Kapat! (Kadına)", ar: "أَغْلِقِي"),
                  ]),
              Sentence(
                  ar: "اُكْتُبْ فِي الدَّفْتَرِ",
                  tr: "Deftere yaz! (Erkeğe)",
                  words: [
                    Word(tr: "Yaz! (Erkeğe)", ar: "اُكْتُبْ"),
                    Word(tr: "İçinde", ar: "فِي"),
                    Word(tr: "Defter", ar: "دَفْتَرٌ")
                  ]),
              Sentence(
                  ar: "اُكْتُبِي فِي الدَّفْتَرِ",
                  tr: "Deftere yaz! (Kadına)",
                  words: [
                    Word(tr: "Yaz! (Kadına)", ar: "اُكْتُبِي"),
                    Word(tr: "İçinde", ar: "فِي"),
                    Word(tr: "Defter", ar: "دَفْتَرٌ")
                  ]),
            ],
          ),
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
