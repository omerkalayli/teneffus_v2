import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:teneffus/constants.dart';
import 'package:teneffus/games/presentation/pages/games_page.dart';
import 'package:teneffus/global_widgets/custom_scaffold.dart';
import 'package:teneffus/main/nav_bar_item.dart';
import 'package:teneffus/main/presentation/pages/main_page.dart';
import 'package:teneffus/global_widgets/custom_bottom_nav_bar.dart';
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
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          PageView(
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
          CustomBottomNavBar(
              currentIndex: currentIndex, pageController: pageController),
        ],
      ),
    );
  }
}
