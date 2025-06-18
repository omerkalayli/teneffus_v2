import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:teneffus/global_entities/unit.dart';

/// This widget is used to select a unit in the game. It shows a list of units

class UnitSelectionBar extends StatelessWidget {
  const UnitSelectionBar({
    super.key,
    required this.units,
    required this.selectedUnitNumber,
    required this.onTap,
    this.color,
  });

  final Function(int) onTap;
  final List<Unit> units;
  final ValueNotifier<int> selectedUnitNumber;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    Color selectedUnitColor = color ?? Colors.blue;
    Color unSelectedUnitColor = Colors.grey.shade400;
    Color selectedBorderColor = const Color(0xfff5f5f5);
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height: 6,
          width: double.infinity,
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 219, 219, 219),
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            for (int i = 0; i < units.length; i++)
              InkWell(
                borderRadius: BorderRadius.circular(20),
                onTap: () {
                  onTap(i);
                },
                child: AnimatedContainer(
                  curve: Curves.easeInOut,
                  duration: Durations.short4,
                  height: 30,
                  padding:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
                  decoration: BoxDecoration(
                    color: selectedUnitNumber.value == i
                        ? selectedUnitColor
                        : unSelectedUnitColor,
                    border: Border.all(
                        width: 2,
                        color: selectedUnitNumber.value != i
                            ? selectedBorderColor
                            : selectedUnitColor),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: AnimatedDefaultTextStyle(
                      curve: Curves.bounceOut,
                      duration: Durations.short3,
                      style: GoogleFonts.montserrat(
                        fontSize: 10,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      child: Text("${i + 1}. Ünite"),
                    ),
                  ),
                ),
              )
          ],
        )
      ],
    );
  }
}
