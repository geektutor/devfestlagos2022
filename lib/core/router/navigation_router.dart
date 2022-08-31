import 'package:devfest/core/router/routes.dart';
import 'package:devfest/views/controller_page/controller_page.dart';
import 'package:devfest/views/onboarding/onboarding_page.dart';
import 'package:devfest/views/signin_page/alert_page.dart';
import 'package:devfest/views/signin_page/signin_page.dart';
import 'package:devfest/views/speakers_page/more_info.dart';
import 'package:devfest/views/speakers_page/speakers_page.dart';
import 'package:devfest/views/splash_page.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  initialLocation: Routes.controllerPage,
  //initialLocation: Routes.onboardingPage,
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
      path: Routes.alertPage,
      builder: (context, state) {
        AlertParams params =
            (state.extra as Map<String, dynamic>)['type'] as AlertParams;
        return AlertPage(
          params: params,
        );
      },
    ),
    GoRoute(
      path: Routes.controllerPage,
      builder: (context, state) => const ControllerPage(),
    ),
    GoRoute(
        path: Routes.speakerPage,
        builder: ((context, state) => SpeakersPage())),
    GoRoute(
        path: Routes.moreInfoPage,
        builder: ((context, state) => MoreInfoPage())),
  ],
);
