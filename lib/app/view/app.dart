import 'package:devfest/core/router/router.dart';
import 'package:devfest/state/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:devfest/bootstrap.dart';
import 'package:devfest/l10n/l10n.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      observers: [AppProviderObserver()],
      child: const ProviderScopeApp(),
    );
  }
}

class ProviderScopeApp extends HookConsumerWidget {
  const ProviderScopeApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final theme = ref.watch(themeVM)

      /// Force potrait mode on Android & iOS.
      ..handlePortraitMode();

    return AnnotatedRegion(
      value: theme.style,
      child: MaterialApp.router(
        routeInformationProvider: router.routeInformationProvider,
        routeInformationParser: router.routeInformationParser,
        routerDelegate: router.routerDelegate,
        debugShowCheckedModeBanner: false,
        theme: theme.themeData,
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
        ],
        supportedLocales: AppLocalizations.supportedLocales,
      ),
    );
  }
}
