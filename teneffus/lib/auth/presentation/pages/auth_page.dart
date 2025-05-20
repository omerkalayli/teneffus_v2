import 'package:auto_route/auto_route.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:teneffus/auth/auth_state.dart';
import 'package:teneffus/auth/presentation/auth_notifier.dart';
import 'package:teneffus/auth/presentation/pages/auth_login_page.dart';
import 'package:teneffus/auth/presentation/pages/auth_register_page.dart';
import 'package:teneffus/constants.dart';
import 'package:teneffus/global_entities/snackbar_type.dart';
import 'package:teneffus/global_widgets/custom_circular_progress_indicator.dart';
import 'package:teneffus/global_widgets/custom_scaffold.dart';
import 'package:teneffus/global_widgets/custom_snackbar.dart';
import 'package:teneffus/global_widgets/stroked_text.dart';
import 'package:teneffus/main/main_layout.dart';
import 'package:teneffus/validator.dart';

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
    final authState = ref.watch(authNotifierProvider);
    final isStudent = ref.watch(userTypeProvider);
    final userInformation = isStudent == true
        ? ref.watch(authNotifierProvider.notifier).studentInformation
        : ref.watch(authNotifierProvider.notifier).teacherInformation;

    listenAuthState(ref, context);

    if (userInformation != null) {
      return const MainLayoutPage();
    }

    return Stack(
      children: [
        authState.value == const AuthState.initialLoading()
            ? const CustomScaffold(
                body: CustomCircularProgressIndicator(
                  disableBackgroundColor: true,
                  showAppTitle: true,
                ),
              )
            : CustomScaffold(
                appBar: AppBar(
                  leading: authState.value == const AuthState.register()
                      ? IconButton(
                          onPressed: () {
                            ref
                                .read(authNotifierProvider.notifier)
                                .redirectToUnauthenticated();
                          },
                          icon: const Icon(
                            Icons.chevron_left_rounded,
                            color: Colors.white,
                            size: 48,
                          ))
                      : Container(),
                  backgroundColor: Colors.transparent,
                ),
                body: Padding(
                  padding:
                      const EdgeInsets.only(left: 24.0, right: 24, top: 24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      StrokedText(
                        "TENEFFÜS",
                        strokeWidth: 6,
                        style: GoogleFonts.luckiestGuy(
                            textStyle: Theme.of(context)
                                .textTheme
                                .headlineMedium!
                                .copyWith(
                          fontSize: 48,
                          shadows: [headerShadow],
                        )),
                      ),
                      Expanded(
                        child: CarouselSlider(
                          carouselController: carouselController,
                          options: CarouselOptions(
                            initialPage:
                                authState.value == const AuthState.register()
                                    ? 1
                                    : 0,
                            height: double.infinity,
                            enableInfiniteScroll: false,
                            viewportFraction: 1,
                          ),
                          items: const [AuthLoginPage(), AuthRegisterPage()],
                        ),
                      ),
                      const Gap(16),
                    ],
                  ),
                ),
              ),
        if (authState.value == const AuthState.loading())
          const CustomCircularProgressIndicator()
      ],
    );
  }
}

void listenAuthState(WidgetRef ref, BuildContext context) {
  ref.listen(authNotifierProvider, (oldState, state) {
    if (oldState?.value == const AuthState.loading() &&
        state.value == const AuthState.register()) {
      ref.read(carouselControllerProvider).animateToPage(1);
    } else if (oldState?.value == const AuthState.register() &&
        state.value == const AuthState.unauthenticated()) {
      ref.read(carouselControllerProvider).animateToPage(0);
    }
    state.value?.maybeWhen(
        orElse: () {},
        error: (message) {
          CustomSnackbar.show(
              type: SnackbarType.error(),
              message: Validator.validateErrorMessage(errorMessage: message),
              context: context);
        });
  });
}
