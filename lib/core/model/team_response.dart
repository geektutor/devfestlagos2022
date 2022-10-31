class TeamMember {
  final String? id;
  final String? name;
  final String? role;
  final String? avatar;
  final String? twitterUrl;
  final String? organization;

  const TeamMember({
    this.id,
    this.name,
    this.role,
    this.avatar,
    this.twitterUrl,
    this.organization,
  });

  factory TeamMember.fromJson(Map<String, dynamic> json) => TeamMember(
        id: json['id'],
        name: json['name'],
        role: json['role'],
        avatar: json['avatar'],
        twitterUrl: json['twitter'],
        organization: json['organization'],
      );
}
