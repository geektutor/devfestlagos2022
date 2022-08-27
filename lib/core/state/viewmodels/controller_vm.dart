import 'package:devfest/views/controller_page/controller_page_item.dart';
import 'package:devfest/views/controller_page/tabs/home/home_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ControllerVM extends ChangeNotifier {
  final Reader read;

  ControllerVM(this.read);

  int _currentTab = 0;
  int get currentTab => _currentTab;
  set currentTab(int val) {
    _currentTab = val;
    notifyListeners();
  }

  Widget? _currentPage;
  Widget? get currentPage => _currentPage;
  set currentPage(Widget? val) {
    _currentPage = val;
    notifyListeners();
  }

  Widget get defaultPage => IndexedStack(
        index: currentTab,
        children: [...pages.map((e) => e.page)],
      );

  final pages = <ControllerPageItem>[
    const ControllerPageItem(
      page: HomePage(
        key: PageStorageKey<String>('home'),
      ),
      image: 'home',
      name: 'Home',
    ),
    const ControllerPageItem(
      page: HomePage(
        key: PageStorageKey<String>('agenda'),
      ),
      image: 'agenda',
      name: 'Agenda',
    ),
    const ControllerPageItem(
      page: HomePage(
        key: PageStorageKey<String>('map'),
      ),
      image: 'map',
      name: 'Map',
    ),
    const ControllerPageItem(
      page: HomePage(
        key: PageStorageKey<String>('speakers'),
      ),
      image: 'speakers',
      name: 'Speakers',
    ),
    const ControllerPageItem(
      page: HomePage(
        key: PageStorageKey<String>('You'),
      ),
      image: 'you',
      name: 'You',
    ),
  ];

  /// Handle bottom navigation bar index change
  void onPageChanged(int index) {
    if (currentTab == index) {
      return;
    }
    currentTab = index;
    returnToDefaultPage();
  }

  void returnToDefaultPage() => currentPage = defaultPage;
}
