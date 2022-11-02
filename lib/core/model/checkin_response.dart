import 'package:devfest/core/model/user_info.dart';

class CheckinResponse {
  final String? message;
  final UserAttendanceInfoModel? user;

  const CheckinResponse({this.message, this.user});

  factory CheckinResponse.fromJson(Map<String, dynamic> json) =>
      CheckinResponse(
        message: json['message'],
        user: UserAttendanceInfoModel //
            .fromJson(json['user'] as Map<String, dynamic>),
      );
}
