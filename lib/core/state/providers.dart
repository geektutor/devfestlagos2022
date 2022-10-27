import 'package:devfest/core/state/viewmodels/viewmodels.dart';
import 'package:devfest/services/auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final homeVM = ChangeNotifierProvider((_) => HomeVM(_.read));
final signinVM = ChangeNotifierProvider((_) => SigninVM(_.read));
final controllerVM = ChangeNotifierProvider((_) => ControllerVM(_.read));
final themeVM = ChangeNotifierProvider((_) => ThemeVM());
final speakersVM = ChangeNotifierProvider((_) => SpeakersVM());
final authProvider = Provider((_) => AuthImpl());
