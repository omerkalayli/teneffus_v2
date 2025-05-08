import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:teneffus/global_entities/lesson.dart';

/// This widget is used to select a lesson in the game. It shows a list of lessons

class LessonSelectionDropdown extends HookConsumerWidget {
  const LessonSelectionDropdown({
    super.key,
    required this.lessons,
    required this.selectedLesson,
    required this.onSelected,
    required this.isAllLessensSelected,
  });

  final Function(int) onSelected;
  final List<Lesson> lessons;
  final int selectedLesson;
  final bool isAllLessensSelected;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DropdownMenuTheme(
      key: ValueKey(lessons.hashCode),
      data: DropdownMenuThemeData(
        textStyle: GoogleFonts.montserrat(
            fontSize: 12,
            color: isAllLessensSelected
                ? const Color.fromARGB(255, 7, 114, 131)
                : Colors.white,
            fontWeight: FontWeight.bold),
        inputDecorationTheme: InputDecorationTheme(
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        menuStyle: const MenuStyle(
          padding: WidgetStatePropertyAll(EdgeInsets.zero),
          visualDensity: VisualDensity.compact,
        ),
      ),
      child: DropdownMenu(
        enabled: !isAllLessensSelected,
        initialSelection: selectedLesson + 1,
        trailingIcon: Icon(
          Icons.arrow_drop_down_rounded,
          color: isAllLessensSelected
              ? const Color.fromARGB(255, 7, 114, 131)
              : Colors.white,
          size: 30,
        ),
        selectedTrailingIcon: Icon(
          Icons.arrow_drop_up_rounded,
          color: isAllLessensSelected
              ? const Color.fromARGB(255, 7, 114, 131)
              : Colors.white,
          size: 30,
        ),
        inputDecorationTheme: InputDecorationTheme(
          isCollapsed: true,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          border: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(12),
          ),
          disabledBorder: OutlineInputBorder(
            borderSide:
                const BorderSide(color: Color.fromARGB(255, 7, 114, 131)),
            borderRadius: BorderRadius.circular(12),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(12),
          ),
          constraints: const BoxConstraints(maxHeight: 30),
        ),
        width: MediaQuery.of(context).size.width / 1.8,
        menuStyle: MenuStyle(
          padding: const WidgetStatePropertyAll(EdgeInsets.zero),
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: const BorderSide(color: Colors.white),
            ),
          ),
        ),
        dropdownMenuEntries: [
          ...List.generate(lessons.length, (index) {
            return DropdownMenuEntry(
              value: index + 1,
              label: lessons[index].nameTr,
              style: ButtonStyle(
                textStyle: WidgetStatePropertyAll(
                  GoogleFonts.montserrat(
                      fontSize: 10,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
            );
          }),
        ],
        onSelected: (value) {
          onSelected((value as int) - 1);
        },
      ),
    );
  }
}
