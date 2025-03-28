class MaterialMine {
  final int id;
  final String name;
  final String? status;
  final double? quantity;

  const MaterialMine({
    required this.id,
    required this.name,
    this.status,
    this.quantity,
  });
}
