import 'package:flutter/material.dart';
import 'package:teneffus/constants.dart';

/// A widget that represents a navigation bar item.

class NavBarItem extends StatelessWidget {
  const NavBarItem({
    required this.onTap,
    required this.isSelected,
    required this.label,
    required this.icon,
    super.key,
  });

  final String label;
  final IconData icon;
  final bool isSelected;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        AnimatedPositioned(
          curve: !isSelected ? Curves.easeInOut : Curves.easeInOut,
          duration: !isSelected ? Durations.short4 : Durations.short4,
          bottom: isSelected ? 64 : 16,
          child: InkWell(
            onTap: () {
              onTap.call();
            },
            child: AnimatedContainer(
              duration: Durations.short3,
              height: 80,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  border: isSelected
                      ? Border.all(width: 3, color: Colors.white)
                      : null,
                  color: navBarOrange,
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
                    color: Colors.white,
                    icon,
                    size: 32,
                  ),
                  Text(
                    label,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
