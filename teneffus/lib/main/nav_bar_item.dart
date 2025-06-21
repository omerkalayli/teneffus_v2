import 'package:flutter/material.dart';
import 'package:teneffus/constants.dart';
import 'package:teneffus/gen/assets.gen.dart';

/// A widget that represents a navigation bar item.

class NavBarItem extends StatelessWidget {
  const NavBarItem({
    required this.onTap,
    required this.isSelected,
    required this.label,
    required this.icon,
    required this.isStudent,
    required this.color,
    super.key,
  });

  final String label;
  final AssetGenImage icon;
  final bool isSelected;
  final Function onTap;
  final bool isStudent;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        AnimatedPositioned(
          curve: !isSelected ? Curves.easeInOut : Curves.easeInOut,
          duration: !isSelected ? Durations.short4 : Durations.short4,
          bottom: isSelected ? 0 : 0,
          child: InkWell(
            borderRadius: BorderRadius.circular(24),
            onTap: () {
              onTap.call();
            },
            child: SizedBox(
              height: 80,
              child: AnimatedContainer(
                duration: Durations.short3,
                width: MediaQuery.of(context).size.width / (isStudent ? 6 : 4),
                padding: const EdgeInsets.all(8),
                margin: const EdgeInsets.all(8),
                height: 76,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    border: isSelected
                        ? Border.all(width: 2.5, color: color)
                        : null,
                    color: Colors.white,
                    boxShadow: !isSelected
                        ? []
                        : [
                            BoxShadow(
                                color: Colors.black.withValues(alpha: 0.25),
                                offset: const Offset(0, 4),
                                blurRadius: 4)
                          ]),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    icon.image(width: 64, height: 32, color: color),
                    // AutoSizeText(
                    //   label,
                    //   maxLines: 1,
                    //   textAlign: TextAlign.center,
                    //   style: const TextStyle(
                    //       color: textColor,
                    //       fontWeight: FontWeight.bold,
                    //       fontSize: 12),
                    // )
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
