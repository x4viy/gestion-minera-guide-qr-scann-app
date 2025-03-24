class Material {
  final int id;
  final String name;
  final String? status;
  final double? quantity;

  const Material({
    required this.id,
    required this.name,
    this.status,
    this.quantity,
  });
}
