import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:devfest/core/state/viewmodels/viewmodels.dart';

final homeVM = ChangeNotifierProvider((_) => HomeVM(_.read));
final controllerVM = ChangeNotifierProvider((_) => ControllerVM(_.read));
final themeVM = ChangeNotifierProvider((_) => ThemeVM());
