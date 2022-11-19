class CheckinRequest {
  final String email;

  const CheckinRequest({required this.email});

  Map<String, dynamic> toJson() => {
        'email': email,
      };
}
