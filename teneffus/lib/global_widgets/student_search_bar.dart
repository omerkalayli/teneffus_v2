import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:teneffus/constants.dart';
import 'package:teneffus/games/presentation/widgets/custom_dropdown.dart';

class StudentSearchBar extends StatelessWidget {
  const StudentSearchBar({
    super.key,
    required this.textEditingController,
    required this.onSelectionChanged,
    required this.selectedStudentGrade,
    this.baseColor = Colors.white,
    this.isAscending,
  });

  final TextEditingController textEditingController;
  final ValueNotifier<int> selectedStudentGrade;
  final ValueNotifier<bool>? isAscending;
  final void Function(int) onSelectionChanged;
  final Color baseColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: SizedBox(
                height: 30,
                child: Theme(
                  data: Theme.of(context).copyWith(
                    textSelectionTheme: TextSelectionThemeData(
                      selectionColor: baseColor,
                      cursorColor: baseColor,
                    ),
                  ),
                  child: TextField(
                    controller: textEditingController,
                    style: TextStyle(color: baseColor, fontSize: 12),
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.only(left: 8),
                      hintText: "Öğrenci Ara",
                      hintStyle: TextStyle(
                          color: baseColor.withValues(alpha: 0.8),
                          fontSize: 12),
                      filled: true,
                      fillColor: baseColor.withValues(alpha: 0.08),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                )),
          ),
          const Gap(8),
          CustomDropdown(
              baseColor: baseColor,
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
          if (isAscending != null) ...[
            const Gap(8),
            InkWell(
              onTap: () {
                isAscending!.value = !isAscending!.value;
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: baseColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      isAscending!.value ? "Artan" : "Azalan",
                      style: const TextStyle(color: wordsColor, fontSize: 12),
                    ),
                    const Gap(2),
                    Icon(
                      isAscending!.value
                          ? Icons.arrow_upward_rounded
                          : Icons.arrow_downward_rounded,
                      color: wordsColor,
                      size: 16,
                    ),
                  ],
                ),
              ),
            ),
          ]
        ],
      ),
    );
  }
}
