import 'package:flutter/material.dart';
import 'package:teneffus/constants.dart';
import 'package:teneffus/gen/assets.gen.dart';
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
          height: 80,
          width: double.infinity,
          decoration: const BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                offset: Offset(0, -2),
                blurRadius: 4,
              ),
            ],
            border: Border(top: BorderSide(width: 2, color: Colors.white)),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          height: 120,
          child: Row(
            children: [
              Expanded(
                child: NavBarItem(
                  color: currentIndex.value == 0 ? homeworksColor : textColor,
                  isStudent: isStudent,
                  isSelected: currentIndex.value == 0,
                  icon: isStudent
                      ? Assets.images.homeworks
                      : Assets.images.addHomework,
                  label: isStudent ? "Görevlerim" : "Görev Oluştur",
                  onTap: () {
                    pageController.jumpToPage(0);
                  },
                ),
              ),
              Expanded(
                child: NavBarItem(
                  color: currentIndex.value == 1
                      ? isStudent
                          ? gamesColor
                          : homeColor
                      : textColor,
                  isStudent: isStudent,
                  isSelected: currentIndex.value == 1,
                  icon: isStudent ? Assets.images.games : Assets.images.home,
                  label: isStudent ? " Oyunlar " : "Ana Menü",
                  onTap: () {
                    pageController.jumpToPage(1);
                  },
                ),
              ),
              Expanded(
                child: NavBarItem(
                  color: currentIndex.value == 2
                      ? isStudent
                          ? homeColor
                          : wordsColor
                      : textColor,
                  isStudent: isStudent,
                  isSelected: currentIndex.value == 2,
                  label: isStudent ? "Ana Menü" : "Öğrenciler",
                  icon: isStudent ? Assets.images.home : Assets.images.students,
                  onTap: () {
                    pageController.jumpToPage(2);
                  },
                ),
              ),
              if (isStudent)
                Expanded(
                  child: NavBarItem(
                    color: currentIndex.value == 3 ? wordsColor : textColor,
                    isStudent: isStudent,
                    isSelected: currentIndex.value == 3,
                    icon: Assets.images.words,
                    label: "Kelimeler",
                    onTap: () {
                      pageController.jumpToPage(3);
                    },
                  ),
                ),
              if (isStudent)
                Expanded(
                  child: NavBarItem(
                    color: currentIndex.value == 4 ? profileColor : textColor,
                    isStudent: isStudent,
                    isSelected: currentIndex.value == 4,
                    icon: Assets.images.profile,
                    label: "Profil  ",
                    onTap: () {
                      pageController.jumpToPage(4);
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
