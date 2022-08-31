import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class SpeakersVM extends ChangeNotifier {
  var backgroundImage = '';

  var title = '';
  var avatar = '';
  var firstName = '';
  var lastName = '';
  var role = '';
  var time = '';
  var venue = '';

  var synopsis = '';

  void updateSpeaker(
      {var backgroundImage,
      title,
      avatar,
      firstName,
      lastName,
      role,
      time,
      venue}) {
    this.backgroundImage = backgroundImage;
    this.title = title;
    this.avatar = avatar;
    this.firstName = firstName;
    this.lastName = lastName;
    this.role = role;
    this.time = time;
    this.venue = venue;
  }
}
