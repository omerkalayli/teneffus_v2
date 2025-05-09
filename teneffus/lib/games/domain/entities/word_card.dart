import 'package:flutter_flip_card/controllers/flip_card_controllers.dart';

class WordCard {
  final String word;
  final FlipCardController controller;
  final String id;
  final int index;

  WordCard(
      {required this.word,
      required this.controller,
      required this.id,
      required this.index});
}
