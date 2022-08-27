import 'dart:io';

import 'package:devfest/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ThemeVM extends ChangeNotifier {
  Color _systemNavigationBarColor = AppColors.white;
  Color get systemNavigationBarColor => _systemNavigationBarColor;
  set systemNavigationBarColor(Color val) {
    _systemNavigationBarColor = val;
    notifyListeners();
  }

  /// App's Theme data
  ThemeData get themeData => ThemeData(
        primaryColor: Colors.blue,
        brightness: Brightness.light,
        fontFamily: 'ProductSans',
        backgroundColor: AppColors.kBackground,
        colorScheme: const ColorScheme.light(
          primary: Colors.blue,
        ),
        useMaterial3: false,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      );

  /// Force potriat mode for app
  void handlePortraitMode() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  /// System overlay style
  SystemUiOverlayStyle get style => SystemUiOverlayStyle(
        /* set Status bar color in Android devices. */
        statusBarColor: Colors.transparent,
        systemNavigationBarDividerColor: Colors.transparent,
        /* set Status bar icons color in Android devices.*/
        statusBarIconBrightness:
            (Platform.isIOS ? Brightness.dark : Brightness.dark),
        /* set Status bar icon color in iOS. */
        statusBarBrightness: Brightness.dark,
        systemNavigationBarColor: systemNavigationBarColor,
        systemNavigationBarIconBrightness: Brightness.light,
      );
}
