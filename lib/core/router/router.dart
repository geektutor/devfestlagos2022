import 'dart:io';

import 'package:devfest/views/controller_page/tabs/home/sub_pages/contributors_page.dart';
import 'package:devfest/views/controller_page/tabs/home/sub_pages/sponsors_page.dart';
import 'package:devfest/views/controller_page/tabs/home/sub_pages/teams_page.dart';
import 'package:devfest/views/onboarding/onboarding_page.dart';
import 'package:devfest/views/signin_page/signin_page.dart';
import 'package:devfest/views/splash_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../views/controller_page/controller_page.dart';
import '../../views/controller_page/tabs/home/sub_pages/talk_categories_sub_page.dart';
import '../../views/signin_page/alert_page.dart';
import '../../views/speakers_page/more_info.dart';
import '../../views/speakers_page/speakers_page.dart';
import 'routes.dart';

abstract class AppRouter {
  static Route<dynamic> generateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splashPage:
        return getPageRoute(
          settings: settings,
          view: const SplashPage(),
        );

      case Routes.onboardingPage:
        return getPageRoute(
          settings: settings,
          view: const OnboardingPage(),
        );

      case Routes.signInPage:
        return getPageRoute(
          settings: settings,
          view: const SignInPage(),
        );

      case Routes.alertPage:
        AlertParams params =
            (settings.arguments as Map<String, dynamic>)['type'] as AlertParams;
        return getPageRoute(
          settings: settings,
          view: AlertPage(
            params: params,
          ),
        );
      case Routes.controllerPage:
        return getPageRoute(
          settings: settings,
          view: const ControllerPage(),
        );

      case Routes.speakerPage:
        return getPageRoute(
          settings: settings,
          view: const SpeakersPage(),
        );

      case Routes.moreInfoPage:
        return getPageRoute(
          settings: settings,
          view: const MoreInfoPage(),
        );

      case Routes.allTalkPage:
        return getPageRoute(
          settings: settings,
          view: const TalkCategoriesSubPage(),
        );

      case Routes.sponsorsPage:
        return getPageRoute(
          settings: settings,
          view: const SponsorsPage(),
        );

      case Routes.teamPage:
        return getPageRoute(
          settings: settings,
          view: const TeamsPage(),
        );

      case Routes.contributorPage:
        return getPageRoute(
          settings: settings,
          view: const ContributorsPage(),
        );

      default:
        return getPageRoute(
          settings: settings,
          view: Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }

  static PageRoute<dynamic> getPageRoute({
    required RouteSettings settings,
    required Widget view,
  }) {
    return Platform.isIOS
        ? CupertinoPageRoute(settings: settings, builder: (_) => view)
        : MaterialPageRoute(settings: settings, builder: (_) => view);
  }
}
