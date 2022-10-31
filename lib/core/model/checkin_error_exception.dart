class CheckinException implements Exception {
  const CheckinException();
  factory CheckinException.fromJson(Map<String, dynamic> json) =>
      const CheckinException();
}
