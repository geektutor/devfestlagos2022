class Sponsor {
  final String? id;
  final String? name;
  final String? website;
  final String? backgroundImage;
  final String? logoImage;

  const Sponsor({
    this.id,
    this.name,
    this.website,
    this.backgroundImage,
    this.logoImage,
  });

  factory Sponsor.fromJson(Map<String, dynamic> json) => Sponsor(
        id: json['id'],
        name: json['name'],
        website: json['website'],
        backgroundImage: json['backgroundImageUrl'],
        logoImage: json['logoUrl'],
      );
}
