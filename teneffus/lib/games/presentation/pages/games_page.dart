import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fpdart/fpdart.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:teneffus/arabic/getter/getter.dart';
import 'package:teneffus/auth/data/auth_firebase_db.dart';
import 'package:teneffus/auth/presentation/auth_notifier.dart';
import 'package:teneffus/constants.dart';
import 'package:teneffus/games/presentation/widgets/unit_selection_bar.dart';
import 'package:teneffus/global_entities/unit.dart';

class GamesPage extends HookConsumerWidget {
  const GamesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedUnitNumber = useState(0);
    final selectedLesson = useState(0);
    final user = ref.watch(authNotifierProvider.notifier).userInformation;
    final grade = user?.grade;
    final units = UnitGetter.getUnits(grade!);
    final lessons = units[selectedUnitNumber.value].lessons;
    final selectedUnit = units[selectedUnitNumber.value];

    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("${selectedUnit.number}. Ünite ${selectedUnit.nameTr}"),
              const Gap(16),
              UnitSelectionBar(
                units: units,
                selectedUnitNumber: selectedUnitNumber,
                onTap: (i) {
                  selectedUnitNumber.value = i;
                  selectedLesson.value = 0;
                },
              ),
              DropdownMenu(
                initialSelection: 0,
                width: double.infinity,
                dropdownMenuEntries: List.generate(lessons.length, (index) {
                  return DropdownMenuEntry(
                    value: index,
                    label: lessons[index].nameTr,
                  );
                }),
                onSelected: (value) {
                  selectedLesson.value = value ?? -1;
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
