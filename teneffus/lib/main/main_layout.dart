import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:teneffus/constants.dart';
import 'package:teneffus/games/presentation/pages/games_page.dart';
import 'package:teneffus/global_widgets/custom_scaffold.dart';
import 'package:teneffus/main/nav_bar_item.dart';
import 'package:teneffus/main/presentation/pages/main_page.dart';
import 'package:teneffus/words/presentation/pages/words_page.dart';

/// MainLayoutPage is the main layout of the app. It consists bottom navigation bar.

@RoutePage()
class MainLayoutPage extends HookConsumerWidget {
  const MainLayoutPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageController = usePageController(initialPage: 1);
    final currentIndex = useState(1);
    return CustomScaffold(
      body: PageView(
        onPageChanged: (index) {
          currentIndex.value = index;
        },
        controller: pageController,
        children: const [
          GamesPage(),
          MainPage(),
          WordsPage(),
        ],
      ),
      bottomNavigationBar: Stack(
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
      ),
    );
  }
}
