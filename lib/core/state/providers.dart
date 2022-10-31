import 'package:devfest/core/model/category_response.dart';
import 'package:devfest/core/model/speakers_response.dart';
import 'package:devfest/core/model/sponsors_response.dart';
import 'package:devfest/core/model/team_response.dart';
import 'package:devfest/core/model/venue_response.dart';
import 'package:devfest/core/state/viewmodels/viewmodels.dart';
import 'package:devfest/services/auth.dart';
import 'package:devfest/services/firestore_db.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../model/session_response.dart';

final homeVM = ChangeNotifierProvider((_) => HomeVM(_.read));
final signinVM = ChangeNotifierProvider((_) => SigninVM(_.read));
final controllerVM = ChangeNotifierProvider((_) => ControllerVM(_.read));
final themeVM = ChangeNotifierProvider((_) => ThemeVM());
final speakersVM = ChangeNotifierProvider((_) => SpeakersVM());
final authProvider = Provider((_) => AuthImpl());
final categoriesStreamProvider = StreamProvider.autoDispose<List<Category>?>(
    (ref) => FirestoreUserDBService.instance.categoriesStream());
final hallsStreamProvider = StreamProvider.autoDispose<List<Hall>?>(
    (ref) => FirestoreUserDBService.instance.hallsStream());
final organizersStreamProvider = StreamProvider.autoDispose<List<TeamMember>?>(
    (ref) => FirestoreUserDBService.instance.organizersStream());
final speakersStreamProvider = StreamProvider.autoDispose<List<Speaker>?>(
    (ref) => FirestoreUserDBService.instance.speakersStream());
final sponsorsStreamProvider = StreamProvider.autoDispose<List<Sponsor>?>(
    (ref) => FirestoreUserDBService.instance.sponsorsStream());

final sessionsStreamProvider =
    StreamProvider.autoDispose<List<Future<Session>>?>(
        (ref) => FirestoreUserDBService.instance.sessionsStream());
