import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class SpeakersVM extends ChangeNotifier {
  String _backgroundImage = '';
  String get backgroundImage => _backgroundImage;
  set backgroundImage(String bgImage) {
    _backgroundImage = bgImage;
    notifyListeners();
  }

  String _title = '';
  String get title => _title;
  set title(String title) {
    _title = title;
    notifyListeners();
  }

  String _avatar = '';
  String get avatar => _avatar;
  set avatar(String avatar) {
    _avatar = avatar;
    notifyListeners();
  }

  String _firstName = '';
  String get firstName => _firstName;
  set firstName(String fName) {
    _firstName = fName;
    notifyListeners();
  }

  String _lastName = '';
  String get lastName => _lastName;
  set lastName(String lName) {
    _lastName = lName;
    notifyListeners();
  }

  String _role = '';
  String get role => _role;
  set role(String role) {
    _role = role;
    notifyListeners();
  }

  String _time = '';
  String get time => _time;
  String get timne => _time;
  set time(String time) {
    _time = time = _time;
    notifyListeners();
  }

  String _venue = '';
  String get venue => _venue;
  set venue(String venue) {
    _venue = venue;
    notifyListeners();
  }

  String _synopsis = '';
  String get synopsis => _synopsis;
  set synopsis(String synopsis) {
    _synopsis = synopsis;
    notifyListeners();
  }

  void updateSpeaker(
      {var bgImage, title, avatar, firstName, lastName, role, time, venue}) {
    this.backgroundImage = bgImage;
    this.title = title;
    this.avatar = avatar;
    this.firstName = firstName;
    this.lastName = lastName;
    this.role = role;
    this.time = time;
    this.venue = venue;
  }
}
