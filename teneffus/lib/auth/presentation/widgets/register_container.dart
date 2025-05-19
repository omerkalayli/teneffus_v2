import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:teneffus/constants.dart';

class RegisterContainer extends StatelessWidget {
  const RegisterContainer({
    required this.onTap,
    super.key,
  });

  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      decoration: BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(width: 2, color: Colors.white)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const Text(
            "Buralarda yeni misin?",
            style: TextStyle(shadows: [textShadowSmall]),
          ),
          InkWell(
            onTap: () async {
              onTap();
            },
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                  color: Colors.teal,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(width: 2, color: Colors.white)),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 2.0),
                child: Row(
                  children: [
                    Gap(8),
                    Text(
                      "Kaydol",
                      style: TextStyle(color: Colors.white),
                    ),
                    Icon(
                      Icons.chevron_right_rounded,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
