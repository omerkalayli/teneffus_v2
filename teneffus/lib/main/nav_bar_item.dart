import 'package:flutter/material.dart';
import 'package:teneffus/constants.dart';

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
  final IconData icon;
  final bool isSelected;
  final Function onTap;
  final bool isStudent;
  final Color color;
// TODO: quiz sentence doğru olduğundd asonrakine geçmiyor. göstermiyor

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
                width: MediaQuery.of(context).size.width / (isStudent ? 6 : 3),
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
                    Icon(
                      color: textColor,
                      icon,
                      size: 32,
                    ),
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
