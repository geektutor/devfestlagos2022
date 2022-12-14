import 'package:devfest/core/state/providers.dart';
import 'package:devfest/views/controller_page/widgets/controller_bottom_nav.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ControllerPage extends StatefulHookConsumerWidget {
  const ControllerPage({Key? key}) : super(key: key);

  @override
  ConsumerState<ControllerPage> createState() => _ControllerPageState();
}

class _ControllerPageState extends ConsumerState<ControllerPage>
    with WidgetsBindingObserver {
  @override
  Widget build(BuildContext context) {
    final currentPage = ref.watch(
      controllerVM.select(
        (it) => it.currentPage,
      ),
    );

    final defaultPage = ref.watch(controllerVM.select(
      (it) => it.defaultPage,
    ));

    return Scaffold(
      // this to prevent the default sliding behaviour
      drawerEnableOpenDragGesture: false,
      body: currentPage ?? defaultPage,
      bottomNavigationBar: const DevFestControllerBottomNav(),
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.resumed) {
      FocusManager.instance.primaryFocus!.unfocus();
    }
  }
}
