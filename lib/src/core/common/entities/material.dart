class MineMaterial {
  final int id;
  final String name;

  MineMaterial({
    required this.id,
    required this.name,
  });

  factory MineMaterial.fromJson(Map<String, dynamic> json) {
    return MineMaterial(
      id: json['id'],
      name: json['name'],
    );
  }
}
