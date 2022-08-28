import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../views/signin_page/alert_page.dart';
import '../../router/routes.dart';

class SigninVM extends ChangeNotifier {
  final Reader read;

  SigninVM(this.read);

  void scanQrCode() {
    // TODO: Implement QR Scanning during implementation
    Routes.currentContext.go(
      Routes.alertPage,
      extra: {
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
    Routes.currentContext.go(Routes.controllerPage);
  }
}
