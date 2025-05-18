import 'package:flutter/material.dart';
import 'package:teneffus/constants.dart';

class HomeworkCardHeader extends StatelessWidget {
  const HomeworkCardHeader({
    super.key,
    required this.teacher,
    required this.formattedDate,
    required this.isCompleted,
  });

  final String teacher;
  final String formattedDate;
  final bool isCompleted;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
          decoration: homeworkCardHeaderDecoration,
          child: Text(
            teacher,
            style: const TextStyle(fontSize: 10, color: Colors.white),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
          decoration: homeworkCardHeaderDecoration,
          child: Text(
            formattedDate,
            style: const TextStyle(fontSize: 10, color: Colors.white),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
          decoration: homeworkCardHeaderDecoration.copyWith(
              color: isCompleted
                  ? Colors.green
                  : Colors.red.withValues(alpha: 0.8)),
          child: Text(
            isCompleted ? "Tamamlandı" : "Tamamlanmadı",
            style: const TextStyle(fontSize: 10, color: Colors.white),
          ),
        ),
      ],
    );
  }
}
