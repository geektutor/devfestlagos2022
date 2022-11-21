class Contributor {
  String? name;
  String? image;
  String? tagline;
  String? portfolio;
  String? linkedIn;
  String? email;
  String? category;
  int? order;

  Contributor({
    this.name,
    this.image,
    this.tagline,
    this.portfolio,
    this.linkedIn,
    this.email,
    this.category,
    this.order,
  });

  Contributor.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    image = json['image'];
    tagline = json['tagline'];
    portfolio = json['portfolio'];
    linkedIn = json['linkedIn'];
    email = json['email'];
    category = json['category'];
    order = json['order'];
  }
}
