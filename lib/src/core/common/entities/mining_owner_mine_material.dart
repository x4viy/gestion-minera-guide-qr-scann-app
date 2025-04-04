class MiningOwnerMineMaterial {
  final int id;
  final double quantity;

  MiningOwnerMineMaterial({
    required this.id,
    required this.quantity,
  });

  factory MiningOwnerMineMaterial.fromJson(Map<String, dynamic> json) {
    return MiningOwnerMineMaterial(
      id: json['id'],
      quantity: (json['quantity'] as num).toDouble(),
    );
  }
}
