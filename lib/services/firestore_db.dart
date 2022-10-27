import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:devfest/core/model/user_info.dart';

class FirestoreUserDBService {
  FirestoreUserDBService._();
  static final instance = FirestoreUserDBService._();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> checkIn(String email) async {
    try {
      await _firestore.collection('User').doc(email).update({
        'checkedIn': true,
        'checkedInTime': Timestamp.now(),
      });
    } on Exception catch (e) {
      log(e.toString());
    }
  }

  Future<void> create(UserAttendanceInfoModel model) async {
    try {
      await _firestore.collection('User').doc(model.email).set(model.toJson());
    } on Exception catch (e) {
      log(e.toString());
    }
  }

  Stream<UserAttendanceInfoModel?> userInfoStream(String email) {
    final reference = _firestore.collection('User').doc(email);
    final snapshots = reference.snapshots();

    return snapshots
        .map((event) => UserAttendanceInfoModel.fromJson(event.data() ?? {}));
  }
}
