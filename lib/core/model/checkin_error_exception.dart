class CheckinException implements Exception {
  const CheckinException([this.message]);
  final String? message;

  factory CheckinException.fromJson(Map<String, dynamic> json) =>
      CheckinException(json['message']);

  @override
  String toString() {
    return message ?? 'An Error Occurred';
  }
}
