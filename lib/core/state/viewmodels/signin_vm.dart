import 'package:devfest/core/router/navigator.dart';
import 'package:devfest/utils/extensions/extensions.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../views/controller_page/tabs/profile/profile_page.dart';
import '../../../views/signin_page/alert_page.dart';
import '../../../widgets/custom_dialog.dart';

enum VmState { busy, none, error }

class SigninVM extends ChangeNotifier {
  final Reader read;

  SigninVM(this.read);

  VmState state = VmState.none;

  void setState(VmState v) {
    if (hasListeners) {
      state = v;
      notifyListeners();
    }
  }

  void scanQrCode(User? user) async {
    if (user?.email?.isEmpty ?? true) {
      return const CustomDialogWidget(
              title: "User not logged in",
              subtitle: "Please login before proceeding to check-in")
          .show(AppNavigator.currentContext);
    }
    setState(VmState.busy);
    try {
      String? data = await Navigator.of(AppNavigator.currentContext)
          .push(MaterialPageRoute(
        builder: (context) => const ScannerView(),
      ));
      if (data == null ||
          !data.contains(
              "https://us-central1-devfestlagos-2022.cloudfunctions.net/")) {
        setState(VmState.error);
        AppNavigator.pushNamed(
          Routes.alertPage,
          arguments: {
            'type': AlertParams(
              type: AlertType.error,
              title: "An error ocurred",
              description:
                  'You must have scanned the wrong qr code. Please try again',
              primaryAction: () => AppNavigator.maybePop(),
              primaryBtnText: 'Go Back',
            )
          },
        );
        return;
      }
      Response<dynamic> response =
          await Dio().post(data, data: {"email": user?.email});

      if (response.statusCode == 200) {
        setState(VmState.none);
        AppNavigator.pushNamed(
          Routes.alertPage,
          arguments: {
            'type': AlertParams(
              type: AlertType.success,
              title:
                  'Welcome to DevFest Lagos, ${user?.displayName?.capitalizeFirstofEach}! 🤗',
              description:
                  'We are glad to have you at DevFest 2022. We hope this becomes a memorable event for you! Stay awesome! 🥰',
              primaryAction: () =>
                  AppNavigator.pushNamedAndClear(Routes.controllerPage),
              primaryBtnText: 'Let\'s Go!!',
            )
          },
        );
        return;
      }
    } catch (e) {
      setState(VmState.error);
      if (e.runtimeType == DioError) {
        AppNavigator.pushNamed(
          Routes.alertPage,
          arguments: {
            'type': AlertParams(
              type: AlertType.error,
              title: (e as DioError).response?.data["message"] ??
                  "An error ocurred",
              description: (e).response?.data["error"] ??
                  'An error ocurred. please try again later.',
              primaryAction: () => AppNavigator.maybePop(),
              primaryBtnText: 'Go Back',
            )
          },
        );
        return;
      } else {
        AppNavigator.pushNamed(
          Routes.alertPage,
          arguments: {
            'type': AlertParams(
              type: AlertType.error,
              title: "An error ocurred",
              description: 'An error ocurred. Please try again later',
              primaryAction: () => AppNavigator.maybePop(),
              primaryBtnText: 'Go Back',
            )
          },
        );
        return;
      }
    }
  }

  void skip() {
    AppNavigator.pushNamedAndClear(Routes.controllerPage);
  }
}
