import 'package:auto_size_text/auto_size_text.dart';
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
          bottom: isSelected ? 24 : 0,
          child: InkWell(
            borderRadius: BorderRadius.circular(24),
            onTap: () {
              onTap.call();
            },
            child: AnimatedContainer(
              duration: Durations.short3,
              width: MediaQuery.of(context).size.width / 5,
              height: 80,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  border: isSelected
                      ? Border.all(width: 2, color: Colors.white)
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
                    size: 24,
                  ),
                  AutoSizeText(
                    label,
                    maxLines: 1,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 12),
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
