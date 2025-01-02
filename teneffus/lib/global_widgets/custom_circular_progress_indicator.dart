import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:teneffus/constants.dart';
import 'package:teneffus/gen/assets.gen.dart';
import 'dart:math';

import 'package:teneffus/global_widgets/stroked_text.dart';

/// A custom circular progress indicator with a loading text.
///
/// If [disableBackgroundColor] is set to true, the background color of the
/// indicator will be transparent.
/// If [showAppTitle] is set to true, the app title will be displayed.

class CustomCircularProgressIndicator extends StatefulWidget {
  const CustomCircularProgressIndicator(
      {this.disableBackgroundColor, this.showAppTitle, super.key});

  final bool? disableBackgroundColor;
  final bool? showAppTitle;

  @override
  State<CustomCircularProgressIndicator> createState() =>
      _CustomCircularProgressIndicatorState();
}

class _CustomCircularProgressIndicatorState
    extends State<CustomCircularProgressIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
      value: 0,
    )..repeat();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: (widget.disableBackgroundColor ?? false)
          ? Colors.transparent
          : Colors.black.withValues(alpha: 0.2),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (widget.showAppTitle ?? false) ...[
              StrokedText(
                "TENEFFÜS",
                strokeWidth: 6,
                style: GoogleFonts.luckiestGuy(
                    textStyle:
                        Theme.of(context).textTheme.headlineMedium!.copyWith(
                  fontSize: 48,
                  shadows: [headerShadow],
                )),
              ),
              const Gap(124),
            ],
            Column(
              children: [
                AnimatedBuilder(
                  animation: _controller,
                  builder: (context, child) {
                    return Transform.rotate(
                      angle: _controller.value * 2 * pi,
                      child: Assets.images.loading.image(
                        width: 64,
                        height: 64,
                      ),
                    );
                  },
                ),
                const Gap(8),
                const Text("Yükleniyor..."),
              ],
            )
          ],
        ),
      ),
    );
  }
}
