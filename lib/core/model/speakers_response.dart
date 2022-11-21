class Speaker {
  final String? name;
  final String? role;
  final String? avatar;
  final String? bio;
  final String? organisation;
  final String? github;
  final String? twitter;
  final String? linkedIn;
  final num? order;
  final String? bgColor;

  const Speaker({
    this.name,
    this.role,
    this.avatar,
    this.bio,
    this.organisation,
    this.github,
    this.twitter,
    this.linkedIn,
    this.order,
    this.bgColor,
  });

  factory Speaker.fromJson(Map<String, dynamic> json,
          {Speaker? speaker, String? bgColor}) =>
      Speaker(
        name: json['name'],
        role: json['role'],
        avatar: json['avatar'],
        bio: json['bio'],
        organisation: json['organisation'],
        github: json['github'],
        twitter: json['twitter'],
        linkedIn: json['linkedIn'],
        order: num.tryParse(json['order'].toString()),
        bgColor: bgColor,
      );
}
