import 'package:auto_route/auto_route.dart';
import 'package:teneffus/app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        // AutoRoute(page: SplashRoute.page, initial: true), // TODO: initial bunu yap.
        AutoRoute(page: AuthRoute.page, initial: true),
        AutoRoute(page: MainLayoutRoute.page),
        AutoRoute(page: QuizRoute.page)
      ];
}
