import 'package:devfest/core/router/routes.dart';
import 'package:devfest/views/onboarding/onboarding_page.dart';
import 'package:devfest/views/splash_page.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  routes: <GoRoute>[
    GoRoute(
      path: Routes.splashPage,
      builder: (context, state) => const SplashPage(),
    ),
    GoRoute(
      path: Routes.onboardingPage,
      builder: (context, state) => const OnboardingPage(),
    ),
  ],
);
