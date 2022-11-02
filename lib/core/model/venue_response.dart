class Hall {
  final String? id;
  final String? name;

  const Hall({
    this.id,
    this.name,
  });

  factory Hall.fromJson(Map<String, dynamic> json) => Hall(
        id: json['id'],
        name: json['name'],
      );
}
