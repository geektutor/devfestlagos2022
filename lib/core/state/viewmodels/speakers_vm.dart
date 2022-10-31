import 'package:devfest/views/controller_page/widgets/agenda_status_chip.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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

  String _name = '';
  String get name => _name;
  set name(String name) {
    _name = name;
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
  set time(String time) {
    _time = time;
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

  AgendaStatus _status = AgendaStatus.pending;
  AgendaStatus get status => _status;
  set status(AgendaStatus status) {
    _status = status;
    notifyListeners();
  }

  void updateSpeaker(
      {var bgImage, title, avatar, name, synopsis, role, time, venue, status}) {
    backgroundImage = bgImage;
    this.title = title;
    this.avatar = avatar;
    this.name = name;
    this.synopsis = synopsis;
    this.role = role;
    this.time = time;
    this.venue = venue;
    this.status = status;
  }
}
