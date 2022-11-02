import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:devfest/core/model/checkin_error_exception.dart';
import 'package:devfest/core/model/checkin_request.dart';
import 'package:devfest/core/model/checkin_response.dart';
import 'package:devfest/core/model/session_response.dart';
import 'package:devfest/core/model/speakers_response.dart';
import 'package:devfest/core/model/sponsors_response.dart';
import 'package:devfest/core/model/user_info.dart';
import 'package:devfest/core/model/venue_response.dart';
import 'package:http/http.dart' as http;

import '../core/model/category_response.dart';
import '../core/model/team_response.dart';

Future<CheckinResponse> checkIn(CheckinRequest request) async {
  final response = await http.post(
    Uri.parse(
        'https://us-central1-devfestlagos-2022.cloudfunctions.net/api/checkin'),
    body: request.toJson(),
  );

  if (response.statusCode == 200) {
    return CheckinResponse.fromJson(jsonDecode(response.body));
  }

  throw CheckinException.fromJson(jsonDecode(response.body));
}

class FirestoreUserDBService {
  FirestoreUserDBService._();
  static final instance = FirestoreUserDBService._();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<UserAttendanceInfoModel?> userInfoStream(String email) {
    final reference = _firestore.collection('User').doc(email);
    final snapshots = reference.snapshots();

    return snapshots
        .map((event) => UserAttendanceInfoModel.fromJson(event.data() ?? {}));
  }

  Stream<List<Future<Session>>?> sessionsStream() {
    final snapshots = _firestore.collection('Session').snapshots();

    return snapshots.map((event) {
      return event.docs.map((e) async {
        final category =
            await (e.data()['category'] as DocumentReference).get();
        final speaker = await (e.data()['speaker'] as DocumentReference).get();
        final venue = await (e.data()['venue'] as DocumentReference).get();

        return Session.fromJson(
          e.data(),
          category: Category.fromJson(
              (category.data() as Map<String, dynamic>?) ?? {}),
          speaker:
              Speaker.fromJson((speaker.data() as Map<String, dynamic>?) ?? {}),
          venue: Hall.fromJson((venue.data() as Map<String, dynamic>?) ?? {}),
        );
      }).toList();
    });
  }

  Stream<List<Category>?> categoriesStream() {
    final snapshots = _firestore.collection('Category').snapshots();
    return snapshots.map(
        (event) => event.docs.map((e) => Category.fromJson(e.data())).toList());
  }

  Stream<List<Hall>?> hallsStream() {
    final snapshots = _firestore.collection('Hall').snapshots();

    return snapshots.map(
        (event) => event.docs.map((e) => Hall.fromJson(e.data())).toList());
  }

  Stream<List<TeamMember>?> organizersStream() {
    final snapshots = _firestore.collection('Organizer').snapshots();

    return snapshots.map((event) =>
        event.docs.map((e) => TeamMember.fromJson(e.data())).toList());
  }

  Stream<List<Speaker>?> speakersStream() {
    final snapshots = _firestore.collection('Speaker').snapshots();

    return snapshots.map(
        (event) => event.docs.map((e) => Speaker.fromJson(e.data())).toList());
  }

  Stream<List<Sponsor>?> sponsorsStream() {
    final snapshots = _firestore.collection('Sponsor').snapshots();

    return snapshots.map(
        (event) => event.docs.map((e) => Sponsor.fromJson(e.data())).toList());
  }
}