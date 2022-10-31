class UserAttendanceInfoModel {
  final bool? checkedIn;
  final String? email;
  final String? firstName;
  final String? lastName;

  const UserAttendanceInfoModel(
      {this.checkedIn, this.email, this.firstName, this.lastName});

  factory UserAttendanceInfoModel.fromJson(Map<String, dynamic> json) =>
      UserAttendanceInfoModel(
        checkedIn: json['checkedIn'],
        email: json['email'],
        firstName: json['firstName'],
        lastName: json['lastName'],
      );

  Map<String, dynamic> toJson() => {
        'checkedIn': checkedIn,
        'email': email,
        'firstName': firstName,
        'lastName': lastName,
      }..removeWhere((key, value) => value == null);
}
