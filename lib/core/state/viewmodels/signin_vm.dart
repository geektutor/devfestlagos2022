import 'package:devfest/core/router/navigator.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../views/signin_page/alert_page.dart';

class SigninVM extends ChangeNotifier {
  final Reader read;

  SigninVM(this.read);

  void scanQrCode() {
    AppNavigator.pushNamed(
      Routes.alertPage,
      arguments: {
        'type': AlertParams(
          type: AlertType.success,
          title: 'Welcome to DevFest Lagos, Samuel! 🤗',
          description:
              'We are glad to have you at DevFest 2022. We hope this becomes a memorable event for you! Stay awesome! 🥰',
          primaryAction: skip,
          primaryBtnText: 'Let\'s Go!!',
        )
      },
    );
  }

  void skip() {
    AppNavigator.pushNamed(Routes.controllerPage);
  }
}
