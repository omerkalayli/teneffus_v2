import 'package:flutter/material.dart';
import 'package:teneffus/constants.dart';
import 'package:teneffus/main/nav_bar_item.dart';

class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.pageController,
  });

  final ValueNotifier<int> currentIndex;
  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          height: 90,
          width: double.infinity,
          margin: const EdgeInsets.all(12),
          decoration: BoxDecoration(
              color: navBarOrange,
              border: Border.all(width: 3, color: Colors.white),
              borderRadius: BorderRadius.circular(22)),
        ),
        Container(
          height: 180,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Expanded(
                child: NavBarItem(
                  isSelected: currentIndex.value == 0,
                  icon: Icons.sports_esports_rounded,
                  label: " Oyunlar ",
                  onTap: () {
                    pageController.animateToPage(
                        duration: Durations.medium1,
                        curve: Curves.linearToEaseOut,
                        0);
                  },
                ),
              ),
              Expanded(
                child: NavBarItem(
                  isSelected: currentIndex.value == 1,
                  label: "Ana Menü",
                  icon: Icons.home_rounded,
                  onTap: () {
                    pageController.animateToPage(
                        duration: Durations.medium1,
                        curve: Curves.linearToEaseOut,
                        1);
                  },
                ),
              ),
              Expanded(
                child: NavBarItem(
                  isSelected: currentIndex.value == 2,
                  icon: Icons.library_books_rounded,
                  label: "Kelimeler",
                  onTap: () {
                    pageController.animateToPage(
                        duration: Durations.medium1,
                        curve: Curves.linearToEaseOut,
                        2);
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
