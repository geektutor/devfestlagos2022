class Category {
  final String? id;
  final String? name;
  final String? imageUrl;

  const Category({
    this.id,
    this.name,
    this.imageUrl,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json['id'],
        name: json['name'],
        imageUrl: json['imageUrl'],
      );
}
