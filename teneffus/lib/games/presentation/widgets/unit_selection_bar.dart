import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:teneffus/constants.dart';
import 'package:teneffus/global_entities/unit.dart';

/// This widget is used to select a unit in the game. It shows a list of units

class UnitSelectionBar extends StatelessWidget {
  const UnitSelectionBar({
    super.key,
    required this.units,
    required this.selectedUnitNumber,
    required this.onTap,
  });

  final Function(int) onTap;
  final List<Unit> units;
  final ValueNotifier<int> selectedUnitNumber;

  @override
  Widget build(BuildContext context) {
    const selectedUnitColor = Color(0xffFF7043);
    const unSelectedUnitColor = Color(0xffFF916E);
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height: 12,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
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
                  curve: Curves.bounceOut,
                  duration: animationDuration,
                  height: 36,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: selectedUnitNumber.value == i
                        ? selectedUnitColor
                        : unSelectedUnitColor,
                    border: Border.all(
                        width: selectedUnitNumber.value == i ? 2 : 1,
                        color: selectedUnitNumber.value == i
                            ? Colors.white
                            : const Color(0xffD9D9D9)),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: AnimatedDefaultTextStyle(
                      curve: Curves.bounceOut,
                      duration: Durations.short3,
                      style: GoogleFonts.montserrat(
                        fontSize: selectedUnitNumber.value == i ? 12 : 10,
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
