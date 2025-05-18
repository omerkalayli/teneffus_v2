import 'package:flutter/material.dart';
import 'package:teneffus/global_entities/lesson.dart';

class HomeworkCard extends StatelessWidget {
  const HomeworkCard({
    super.key,
    required this.grade,
    required this.unitId,
    required this.lesson,
    required this.myScore,
    required this.minScore,
  });

  final int grade;
  final int unitId;
  final Lesson lesson;
  final int myScore;
  final int minScore;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFF7F7F7),
        borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(16), bottomRight: Radius.circular(16)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "$grade. Sınıf ${unitId + 1}. Ünite",
                style: TextStyle(color: Colors.grey[900], fontSize: 12),
              ),
              const SizedBox(height: 4),
              Text(
                lesson.nameTr,
                style: TextStyle(
                  color: Colors.grey[900],
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "Puanım: ${myScore == -1 ? "-" : myScore}",
                style: TextStyle(color: Colors.grey[900], fontSize: 12),
              ),
              const SizedBox(height: 4),
              Text(
                "Min. Puan: $minScore",
                style: TextStyle(color: Colors.grey[900], fontSize: 12),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
