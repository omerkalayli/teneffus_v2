import 'package:flutter/material.dart';
import 'package:teneffus/constants.dart';
import 'package:teneffus/main/nav_bar_item.dart';

class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.pageController,
    required this.isStudent,
  });

  final ValueNotifier<int> currentIndex;
  final PageController pageController;
  final bool isStudent;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          height: 84,
          width: double.infinity,
          decoration: const BoxDecoration(
            color: navBarOrange,
            border: Border(top: BorderSide(width: 2, color: Colors.white)),
          ),
        ),
        SizedBox(
          height: 120,
          child: Row(
            children: [
              Expanded(
                child: NavBarItem(
                  isStudent: isStudent,
                  isSelected: currentIndex.value == 0,
                  icon: isStudent
                      ? Icons.chrome_reader_mode_outlined
                      : Icons.post_add_rounded,
                  label: isStudent ? "Görevlerim" : "Görev Oluştur",
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
                  isStudent: isStudent,
                  isSelected: currentIndex.value == 1,
                  icon: isStudent
                      ? Icons.sports_esports_rounded
                      : Icons.home_rounded,
                  label: isStudent ? " Oyunlar " : "Ana Menü",
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
                  isStudent: isStudent,
                  isSelected: currentIndex.value == 2,
                  label: isStudent ? "Ana Menü" : "Öğrenciler",
                  icon: isStudent ? Icons.home_rounded : Icons.people_rounded,
                  onTap: () {
                    pageController.animateToPage(
                        duration: Durations.medium1,
                        curve: Curves.linearToEaseOut,
                        2);
                  },
                ),
              ),
              if (isStudent)
                Expanded(
                  child: NavBarItem(
                    isStudent: isStudent,
                    isSelected: currentIndex.value == 3,
                    icon: Icons.library_books_rounded,
                    label: "Kelimeler",
                    onTap: () {
                      pageController.animateToPage(
                          duration: Durations.medium1,
                          curve: Curves.linearToEaseOut,
                          3);
                    },
                  ),
                ),
              if (isStudent)
                Expanded(
                  child: NavBarItem(
                    isStudent: isStudent,
                    isSelected: currentIndex.value == 4,
                    icon: Icons.public_rounded,
                    label: "Sosyal  ",
                    onTap: () {
                      pageController.animateToPage(
                          duration: Durations.medium1,
                          curve: Curves.linearToEaseOut,
                          4);
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
