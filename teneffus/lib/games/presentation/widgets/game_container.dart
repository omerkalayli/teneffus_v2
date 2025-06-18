import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:teneffus/gen/assets.gen.dart';

class GameContainer extends StatelessWidget {
  const GameContainer({
    required this.label,
    required this.image,
    required this.onTap,
    required this.foregroundColor,
    required this.backgroundColor,
    super.key,
  });

  final Function() onTap;
  final String label;
  final AssetGenImage image;
  final Color foregroundColor;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () {
        onTap();
      },
      child: Card(
        shadowColor: backgroundColor,
        child: Container(
          width: double.infinity,
          height: 48,
          padding: const EdgeInsets.all(8),
          margin: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Gap(16),
              AutoSizeText(
                label,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: backgroundColor),
              ),
              const Spacer(),
              image.image(fit: BoxFit.contain, width: 48, height: 48),
              const Gap(8),
            ],
          ),
        ),
      ),
    );
  }
}
