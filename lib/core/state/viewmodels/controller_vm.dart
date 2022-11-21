import 'package:devfest/core/router/navigator.dart';
import 'package:devfest/core/state/providers.dart';
import 'package:devfest/views/controller_page/controller_page_item.dart';
import 'package:devfest/views/controller_page/tabs/home/home_page.dart';
import 'package:devfest/views/controller_page/tabs/profile/profile_page.dart';
import 'package:devfest/views/speakers_page/speakers_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../views/controller_page/tabs/agenda/agenda_page.dart';
import '../../../views/sessions_page/sessions_page.dart';

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
      page: AgendaPage(
        key: PageStorageKey<String>('agenda'),
      ),
      image: 'agenda',
      name: 'Agenda',
    ),
    const ControllerPageItem(
      page: SpeakersPage(
        key: PageStorageKey<String>('speakers'),
      ),
      image: 'speakers',
      name: 'Speakers',
    ),
    const ControllerPageItem(
      page: SessionsPage(
        key: PageStorageKey<String>('sessions'),
      ),
      image: 'agenda',
      name: 'Sessions',
    ),
    const ControllerPageItem(
      page: ProfilePage(
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
  }

  void returnToDefaultPage() => AppNavigator.pop();

  void goToTalkCategories() {
    AppNavigator.pushNamed(Routes.allTalkPage);
  }

  void goToAgenda() {
    currentTab = 1;
    notifyListeners();
  }

  void goToSpeakers([String? category]) {
    currentTab = 2;
    notifyListeners();
  }

  void goToSessions([String? category]) {
    read(categoryProvider.notifier).state = category;
    currentTab = 3;
    notifyListeners();
  }
}
