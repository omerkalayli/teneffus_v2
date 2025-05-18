import 'package:flutter/material.dart';
import 'package:teneffus/games/presentation/widgets/custom_dropdown.dart';
import 'package:teneffus/global_entities/lesson.dart';

class LessonSelectionContainer extends StatelessWidget {
  const LessonSelectionContainer({
    super.key,
    required this.isAllLessonsSelected,
    required this.lessons,
    required this.selectedLesson,
  });

  final ValueNotifier<bool> isAllLessonsSelected;
  final List<Lesson> lessons;
  final ValueNotifier<int> selectedLesson;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomDropdown(
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
            style: TextStyle(fontSize: 12),
          ),
        ),
        Checkbox(
            activeColor: const Color(0xffFF6E42),
            side: const BorderSide(color: Colors.white, width: 2),
            value: isAllLessonsSelected.value,
            onChanged: (val) {
              isAllLessonsSelected.value = val ?? false;
            }),
      ],
    );
  }
}
