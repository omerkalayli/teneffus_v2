import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:teneffus/gen/assets.gen.dart';

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
            padding: const EdgeInsets.all(4),
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32.0),
                  child: image.image(),
                ),
                AutoSizeText(
                  label,
                  textAlign: TextAlign.center,
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
