import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:teneffus/games/presentation/widgets/custom_dropdown.dart';

class StudentSearchBar extends StatelessWidget {
  const StudentSearchBar({
    super.key,
    required this.textEditingController,
    required this.onSelectionChanged,
    required this.selectedStudentGrade,
  });

  final TextEditingController textEditingController;
  final ValueNotifier<int> selectedStudentGrade;
  final void Function(int) onSelectionChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: 30,
            child: TextField(
              controller: textEditingController,
              cursorColor: Colors.white,
              style: const TextStyle(color: Colors.white, fontSize: 12),
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.only(left: 8),
                hintText: "Öğrenci Ara",
                hintStyle: TextStyle(
                    color: Colors.white.withValues(alpha: .8), fontSize: 12),
                filled: true,
                fillColor: Colors.white.withValues(alpha: 0.2),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
        ),
        const Gap(8),
        CustomDropdown(
            width: 120,
            items: const [
              "Hepsi",
              "9. Sınıf",
              "10. Sınıf",
              "11. Sınıf",
              "12. Sınıf"
            ],
            selectedIndex: selectedStudentGrade.value - 8,
            onSelected: (index) {
              onSelectionChanged(index + 8);
            },
            disabled: false),
      ],
    );
  }
}
