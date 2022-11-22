import 'package:devfest/core/model/category_response.dart';
import 'package:devfest/core/model/speakers_response.dart';
import 'package:devfest/core/model/sponsors_response.dart';
import 'package:devfest/core/model/team_response.dart';
// import 'package:devfest/core/model/venue_response.dart';
import 'package:devfest/core/state/viewmodels/viewmodels.dart';
import 'package:devfest/services/auth.dart';
import 'package:devfest/services/firestore_db.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../model/contributor_response.dart';
import '../model/session_response.dart';

final homeVM = ChangeNotifierProvider((_) => HomeVM(_.read));
final signinVM = ChangeNotifierProvider((_) => SigninVM(_.read));
final controllerVM = ChangeNotifierProvider((_) => ControllerVM(_.read));
final themeVM = ChangeNotifierProvider((_) => ThemeVM());
final speakersVM = ChangeNotifierProvider((_) => SpeakersVM());
final authProvider = Provider((_) => AuthImpl());
final categoriesStreamProvider = StreamProvider.autoDispose<List<Category>?>(
    (ref) => FirestoreUserDBService.instance.categoriesStream());
final categoryProvider = StateProvider<String?>((ref) => null);
// final hallsStreamProvider = StreamProvider.autoDispose<List<Hall>?>(
//     (ref) => FirestoreUserDBService.instance.hallsStream());
final organizersStreamProvider = StreamProvider.autoDispose<List<TeamMember>?>(
    (ref) => FirestoreUserDBService.instance.organizersStream());
final contributorsStreamProvider =
    StreamProvider.autoDispose<List<Contributor>?>(
        (ref) => FirestoreUserDBService.instance.contributorsStream());
final speakersStreamProvider = StreamProvider.autoDispose<List<Speaker>?>(
    (ref) => FirestoreUserDBService.instance.speakersStream());
final sponsorsStreamProvider = StreamProvider.autoDispose<List<Sponsor>?>(
    (ref) => FirestoreUserDBService.instance.sponsorsStream());

final sessionsStreamProvider = StreamProvider.autoDispose<List<Session>?>(
    (ref) => FirestoreUserDBService.instance.sessionsStream());

class ValueProvider<T> extends InheritedWidget {
  final T value;
  const ValueProvider({
    Key? key,
    required Widget child,
    required this.value,
  }) : super(key: key, child: child);

  static ValueProvider<T> of<T>(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ValueProvider<T>>()!;
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => false;
}
