import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:teneffus/arabic/getter/getter.dart';
import 'package:teneffus/auth/presentation/auth_notifier.dart';
import 'package:teneffus/constants.dart';
import 'package:teneffus/games/presentation/widgets/lesson_selection_container.dart';
import 'package:teneffus/games/presentation/widgets/unit_selection_bar.dart';
import 'package:teneffus/gen/assets.gen.dart';

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
    final isAllLessonsSelected = useState(true);
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding:
              const EdgeInsets.only(left: 16.0, right: 16, top: 16, bottom: 56),
          child: SingleChildScrollView(
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
                const Gap(16),
                LessonSelectionContainer(
                    isAllLessonsSelected: isAllLessonsSelected,
                    lessons: lessons,
                    selectedLesson: selectedLesson),
                const Gap(16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        GameContainer(
                            onTap: () {},
                            label: games.keys.elementAt(0),
                            image: games.values.elementAt(0)),
                        GameContainer(
                            onTap: () {},
                            label: games.keys.elementAt(1),
                            image: games.values.elementAt(1)),
                      ],
                    ),
                    Row(
                      children: [
                        GameContainer(
                            onTap: () {},
                            label: games.keys.elementAt(2),
                            image: games.values.elementAt(2)),
                        GameContainer(
                            onTap: () {},
                            label: games.keys.elementAt(3),
                            image: games.values.elementAt(3)),
                      ],
                    ),
                    Row(
                      children: [
                        GameContainer(
                            onTap: () {},
                            label: games.keys.elementAt(4),
                            image: games.values.elementAt(4)),
                        const Spacer()
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class GameContainer extends StatelessWidget {
  const GameContainer({
    required this.label,
    required this.image,
    required this.onTap,
    super.key,
  });

  final Function() onTap;
  final String label;
  final AssetGenImage image;

  @override
  Widget build(BuildContext context) {
    final containerGradient = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        const Color(0xff2C76ED).withValues(alpha: .53),
        const Color(0xff4340A9).withValues(alpha: .47),
      ],
    );

    return Expanded(
      child: InkWell(
        onTap: () {
          onTap();
        },
        child: AspectRatio(
          aspectRatio: 1,
          child: Container(
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                border: Border.all(width: 2, color: Colors.white),
                gradient: containerGradient,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: .25),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  )
                ]),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32.0),
                  child: image.image(),
                ),
                Text(
                  label,
                  style: const TextStyle(fontSize: 16),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
