import 'package:flutter/material.dart';
import 'package:teneffus/constants.dart';
import 'package:teneffus/games/presentation/widgets/custom_dropdown.dart';
import 'package:teneffus/global_entities/lesson.dart';

class LessonSelectionContainer extends StatelessWidget {
  const LessonSelectionContainer({
    super.key,
    required this.isAllLessonsSelected,
    required this.lessons,
    required this.selectedLesson,
    this.color,
  });

  final ValueNotifier<bool> isAllLessonsSelected;
  final List<Lesson> lessons;
  final Color? color;
  final ValueNotifier<int> selectedLesson;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomDropdown(
          baseColor: Colors.white,
          disabled: isAllLessonsSelected.value,
          items: lessons
              .map(
                (e) => e.nameTr,
              )
              .toList(),
          selectedIndex: selectedLesson.value,
          onSelected: (val) {
            selectedLesson.value = val;
            isAllLessonsSelected.value = false;
          },
        ),
        const Spacer(),
        GestureDetector(
          onTap: () {
            isAllLessonsSelected.value = !isAllLessonsSelected.value;
          },
          child: const Text(
            "Tüm \nKonular",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 12, color: Colors.white),
          ),
        ),
        Checkbox(
            activeColor: Colors.white,
            checkColor: color ?? Colors.blue,
            side: const BorderSide(color: Colors.white, width: 2),
            value: isAllLessonsSelected.value,
            onChanged: (val) {
              isAllLessonsSelected.value = val ?? false;
            }),
      ],
    );
  }
}
