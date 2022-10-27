import 'package:cloud_firestore/cloud_firestore.dart';

class UserAttendanceInfoModel {
  final bool? checkedIn;
  final DateTime? checkedInTime;
  final String? email;
  final String? firstName;
  final String? lastName;

  const UserAttendanceInfoModel(
      {this.checkedIn,
      this.checkedInTime,
      this.email,
      this.firstName,
      this.lastName});

  factory UserAttendanceInfoModel.fromJson(Map<String, dynamic> json) =>
      UserAttendanceInfoModel(
        checkedIn: json['checkedIn'],
        checkedInTime: (json['checkedInTime'] as Timestamp?)?.toDate(),
        email: json['email'],
        firstName: json['firstName'],
        lastName: json['lastName'],
      );

  Map<String, dynamic> toJson() => {
        'checkedIn': checkedIn,
        'checkedInTime':
            checkedInTime != null ? Timestamp.fromDate(checkedInTime!) : null,
        'email': email,
        'firstName': firstName,
        'lastName': lastName,
      }..removeWhere((key, value) => value == null);
}
