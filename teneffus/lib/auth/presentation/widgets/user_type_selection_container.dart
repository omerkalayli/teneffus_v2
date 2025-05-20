import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:teneffus/constants.dart';

class UserTypeSelectionContainer extends StatelessWidget {
  const UserTypeSelectionContainer({
    super.key,
    required this.isStudent,
    required this.onStudentSelected,
    required this.onTeacherSelected,
  });

  final bool isStudent;
  final Function onStudentSelected;
  final Function onTeacherSelected;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: animationDuration,
      decoration: BoxDecoration(
          color: !isStudent ? Colors.cyan.shade700 : Colors.blue,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(width: 2, color: Colors.white)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          InkWell(
            onTap: () {
              onStudentSelected();
            },
            child: Row(
              children: [
                const Text(
                  "Öğrenciyim",
                  style: TextStyle(shadows: [textShadowSmall]),
                ),
                Checkbox(
                    activeColor: Colors.black45,
                    side: const BorderSide(color: Colors.white, width: 2),
                    value: isStudent,
                    onChanged: (val) {
                      onStudentSelected();
                    }),
              ],
            ),
          ),
          InkWell(
            onTap: () {
              onTeacherSelected();
            },
            child: Row(
              children: [
                const Text(
                  "Öğretmenim",
                  style: TextStyle(shadows: [textShadowSmall]),
                ),
                Checkbox(
                    activeColor: Colors.black45,
                    side: const BorderSide(color: Colors.white, width: 2),
                    value: !isStudent,
                    onChanged: (val) {
                      onTeacherSelected();
                    }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
