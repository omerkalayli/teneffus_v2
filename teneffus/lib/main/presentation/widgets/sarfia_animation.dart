import 'package:flutter/material.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:teneffus/gen/assets.gen.dart'; // Eğer image burada ise
// Eğer Assets.images.header.image(...) varsa bu import kalmalı

class SarfiaAnimation extends StatefulWidget {
  const SarfiaAnimation({Key? key}) : super(key: key);

  @override
  State<SarfiaAnimation> createState() => _SarfiaAnimationState();
}

class _SarfiaAnimationState extends State<SarfiaAnimation>
    with TickerProviderStateMixin {
  late AnimationController _shadowController;
  late Animation<Color?> _shadowColorAnimation;
  late Animation<double> _blurRadiusAnimation;
  @override
  void initState() {
    super.initState();

    _shadowController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _shadowColorAnimation = ColorTween(
      begin: Colors.transparent,
      end: Colors.blueGrey,
    ).animate(CurvedAnimation(
      parent: _shadowController,
      curve: Curves.easeInOut,
    ));

    _blurRadiusAnimation = Tween<double>(
      begin: 0,
      end: 10,
    ).animate(CurvedAnimation(
      parent: _shadowController,
      curve: Curves.easeInOut,
    ));

    _startRepeatingAnimation();
  }

  void _startRepeatingAnimation() async {
    while (mounted) {
      await _shadowController.forward();
      await Future.delayed(const Duration(milliseconds: 4000));
      await _shadowController.reverse();
      await Future.delayed(const Duration(milliseconds: 1500));
    }
  }

  @override
  void dispose() {
    _shadowController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedBuilder(
        animation: _shadowController,
        builder: (context, child) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              border: const GradientBoxBorder(
                gradient: LinearGradient(
                  colors: [
                    Colors.lightBlueAccent,
                    Colors.blue,
                  ],
                ),
                width: 2.2,
              ),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: _shadowColorAnimation.value ?? Colors.transparent,
                  blurRadius: _blurRadiusAnimation.value,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Align(
                widthFactor: 0.4,
                heightFactor: 0.3,
                alignment: Alignment.center,
                child: Assets.images.header.image(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: 200,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
