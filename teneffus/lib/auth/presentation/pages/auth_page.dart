import 'package:auto_route/auto_route.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:teneffus/auth/presentation/pages/auth_initial_page.dart';
import 'package:teneffus/auth/presentation/pages/auth_login_page.dart';
import 'package:teneffus/auth/presentation/pages/auth_register_page.dart';
import 'package:teneffus/constants.dart';
import 'package:teneffus/global_widgets/stroked_text.dart';

final pageIndexProvder = StateProvider((ref) {
  return 0;
});

final carouselControllerProvider = Provider<CarouselSliderController>((ref) {
  return CarouselSliderController();
});

@RoutePage()
class AuthPage extends HookConsumerWidget {
  const AuthPage({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final carouselController = ref.watch(carouselControllerProvider);
    final pageIndex = ref.watch(pageIndexProvder);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: pageIndex != 0
            ? IconButton(
                onPressed: () {
                  ref.read(pageIndexProvder.notifier).state = 0;
                  ref
                      .read(carouselControllerProvider)
                      .animateToPage(curve: slideAnimationCurve, 0);
                },
                icon: const Icon(
                  Icons.chevron_left_rounded,
                  color: Colors.white,
                  size: 48,
                ))
            : Container(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            StrokedText(
              "TENEFFÜS",
              strokeWidth: 6,
              style: GoogleFonts.luckiestGuy(
                  textStyle:
                      Theme.of(context).textTheme.headlineMedium!.copyWith(
                fontSize: 48,
                shadows: [headerShadow],
              )),
            ),
            const Gap(64),
            CarouselSlider(
              carouselController: carouselController,
              options: CarouselOptions(
                initialPage: 0,
                scrollPhysics: const NeverScrollableScrollPhysics(),
                height: MediaQuery.of(context).size.height * 0.6,
                enableInfiniteScroll: false,
                viewportFraction: 1,
              ),
              items: [
                const AuthInitialPage(),
                pageIndex == 1
                    ? const AuthLoginPage()
                    : const AuthRegisterPage()
              ],
            ),
          ],
        ),
      ),
    );
  }
}
