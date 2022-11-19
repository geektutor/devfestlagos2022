class Category {
  final String? name;
  final String? imageUrl;

  const Category({
    this.name,
    this.imageUrl,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        name: json['name'],
        imageUrl: json['imageUrl'],
      );
}
