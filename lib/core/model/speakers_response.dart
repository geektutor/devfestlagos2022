class Speaker {
  final String? id;
  final String? name;
  final String? role;
  final String? avatar;
  final String? bio;
  final String? organisation;

  const Speaker({
    this.id,
    this.name,
    this.role,
    this.avatar,
    this.bio,
    this.organisation,
  });

  factory Speaker.fromJson(Map<String, dynamic> json) => Speaker(
        id: json['id'],
        name: json['name'],
        role: json['role'],
        avatar: json['avatar'],
        bio: json['bio'],
        organisation: json['organisation'],
      );
}
