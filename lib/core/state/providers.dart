import 'package:devfest/core/state/viewmodels/maps_vm.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:devfest/core/state/viewmodels/viewmodels.dart';

final homeVM = ChangeNotifierProvider((_) => HomeVM(_.read));
final signinVM = ChangeNotifierProvider((_) => SigninVM(_.read));
final controllerVM = ChangeNotifierProvider((_) => ControllerVM(_.read));
final themeVM = ChangeNotifierProvider((_) => ThemeVM());
final speakersVM = ChangeNotifierProvider((_) => SpeakersVM());
final mapsVm = ChangeNotifierProvider((_) => MapsVM());
