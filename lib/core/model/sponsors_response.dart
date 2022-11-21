class Sponsor {
  final String? name;
  final String? website;
  final String? backgroundImage;
  final String? logoUrl;
  final String? twitterHandle;
  final int? order;

  const Sponsor(
      {this.name,
      this.website,
      this.backgroundImage,
      this.logoUrl,
      this.twitterHandle,
      this.order});

  factory Sponsor.fromJson(Map<String, dynamic> json) => Sponsor(
        name: json['name'],
        website: json['website'],
        backgroundImage: json['backgroundImageUrl'],
        logoUrl: json['logoUrl'],
        order: json['order'],
        twitterHandle: json['twitterHande'],
      );
}
