import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:teneffus/gen/assets.gen.dart';

class StatBanner extends StatelessWidget {
  const StatBanner({
    super.key,
    required this.color,
    required this.title,
    required this.value,
    this.count,
    this.icon,
    this.padding = const EdgeInsets.all(8.0),
    this.isEmpty = false,
  });

  final String value;
  final Color color;
  final bool isEmpty;
  final String title;
  final AssetGenImage? icon;
  final int? count;

  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    Widget child = Stack(
      children: [
        Card(
          shadowColor: color,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: padding,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  const Gap(4),
                  if (icon != null) ...[
                    icon!.image(width: 24, height: 24),
                    const Gap(8)
                  ],
                  Text(
                    title,
                    style: TextStyle(fontSize: 14, color: color),
                  ),
                  const Spacer(),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                        color: Colors.transparent,
                        border: Border.all(width: 2, color: color),
                        borderRadius: BorderRadius.circular(8)),
                    child: Text(
                      isEmpty ? "Tanımlanmadı" : value,
                      style: TextStyle(fontSize: 14, color: color),
                    ),
                  ),
                  const Gap(4),
                ],
              ),
            ),
          ),
        ),
        if (count != null) ...[
          Positioned(
            top: 4,
            left: 4,
            child: RoundedCornerTriangle(color: color, size: 20),
          ),
          const Positioned(
            top: 5,
            left: 9,
            child: const Text(
              "i",
              style: TextStyle(color: Colors.white, fontSize: 8),
            ),
          )
        ]
      ],
    );
    return count != null
        ? Tooltip(
            triggerMode: TooltipTriggerMode.tap,
            message: "$count soru çözüldü.",
            child: child,
          )
        : child;
  }
}

class RoundedCornerTriangle extends StatelessWidget {
  final Color color;
  final double size;
  final double radius;

  const RoundedCornerTriangle({
    super.key,
    required this.color,
    this.size = 40,
    this.radius = 12,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(size, size),
      painter: _RoundedTrianglePainter(color, radius),
    );
  }
}

class _RoundedTrianglePainter extends CustomPainter {
  final Color color;
  final double radius;

  _RoundedTrianglePainter(this.color, this.radius);

  @override
  void paint(Canvas canvas, Size size) {
    final path = Path();
    path.moveTo(0, radius);
    path.quadraticBezierTo(0, 0, radius, 0);
    path.lineTo(size.width, 0);
    path.lineTo(0, size.height);
    path.close();

    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
