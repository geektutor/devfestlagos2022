import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomeVM extends ChangeNotifier {
  final Reader read;

  HomeVM(this.read);
}
