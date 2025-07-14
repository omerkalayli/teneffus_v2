import 'package:flutter/material.dart';
import 'package:teneffus/games/presentation/pages/listening_game_page.dart';
import 'package:teneffus/time.dart';

/// [CardTopContainer] is a widget that displays the top container of a card
/// with statistics information. It shows the type of statistic, value, and
/// additional information based on the type of statistic.

class CardTopContainer extends StatelessWidget {
  const CardTopContainer(
      {super.key,
      required this.type,
      this.value,
      this.all,
      this.count,
      this.currentTime});

  final StatType type;
  final String? value;
  final double? all;
  final int? count;
  final DateTime? currentTime;

  @override
  Widget build(BuildContext context) {
    final isCount = count != null;

    final percentage = isCount ? (count! / all!).clamp(0.0, 1.0) : null;
    String text = "";

    if (type == StatType.correct) {
      text = "Başarı: %${(percentage! * 100).toStringAsFixed(1)}";
    } else if (type == StatType.total) {
      text = "$value kez çalışıldı";
    } else if (type == StatType.date) {
      text = "Son Çalışma: ${value ?? "bilinmiyor"}";
    } else {
      text = "$value";
    }

    Color color;
    if (type == StatType.correct && percentage != null) {
      color = Color.lerp(const Color(0xffE55355), Colors.green, percentage)!;
    } else if (type == StatType.date && value != null) {
      final lastDate =
          DateTime.tryParse(value!) ?? currentTime ?? DateTime.now();
      final daysDiff = currentTime?.difference(lastDate).inDays ??
          DateTime.now().difference(lastDate).inDays;

      if (daysDiff >= 30) {
        color = const Color(0xff8D6E63);
      } else {
        final progress = (30 - daysDiff) / 30;
        color = Color.lerp(const Color(0xff8D6E63),
            const Color.fromARGB(255, 231, 197, 23), progress)!;
      }
    } else {
      color = const Color(0xff587E8D);
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: color,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(8),
          topRight: Radius.circular(8),
        ),
      ),
      child: Text(
        text,
        style: const TextStyle(fontSize: 8, color: Colors.white),
      ),
    );
  }
}
