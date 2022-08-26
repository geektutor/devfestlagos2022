import 'package:devfest/state/viewmodels/home_vm.dart';
import 'package:devfest/state/viewmodels/theme_vm.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final homeVM = ChangeNotifierProvider((_) => HomeVM(_.read));
final themeVM = ChangeNotifierProvider((_) => ThemeVM());
