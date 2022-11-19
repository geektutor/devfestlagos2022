class Hall {
  final String? name;

  const Hall({
    this.name,
  });

  factory Hall.fromJson(Map<String, dynamic> json) => Hall(
        name: json['name'],
      );
}
