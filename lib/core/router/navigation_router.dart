import 'package:devfest/core/router/routes.dart';
import 'package:devfest/views/controller_page/controller_page.dart';
import 'package:devfest/views/onboarding/onboarding_page.dart';
import 'package:devfest/views/signin_page/signin_page.dart';
import 'package:devfest/views/splash_page.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  initialLocation: Routes.onboardingPage,
  routes: <GoRoute>[
    GoRoute(
      path: Routes.splashPage,
      builder: (context, state) => const SplashPage(),
    ),
    GoRoute(
      path: Routes.onboardingPage,
      builder: (context, state) => const OnboardingPage(),
    ),
    GoRoute(
      path: Routes.signInPage,
      builder: (context, state) => const SignInPage(),
    ),
    GoRoute(
      path: Routes.controllerPage,
      builder: (context, state) => const ControllerPage(),
    ),
  ],
);
