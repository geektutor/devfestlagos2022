import 'package:flutter/material.dart';

import 'navigation_router.dart';

abstract class Routes {
  Routes._();

  static final key = router.routerDelegate.navigatorKey;
  static BuildContext get currentContext => key.currentState!.context;

  static const splashPage = '/';
  static const onboardingPage = '/onboarding_page';
  static const signInPage = '/signin_page';
  static const alertPage = '/alert_page';
  static const controllerPage = '/controller_page';
}
