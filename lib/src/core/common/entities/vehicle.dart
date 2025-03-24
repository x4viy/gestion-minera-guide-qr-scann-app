class Vehicle {
  final int id;
  final String card;
  final String brand;
  final String color;
  final int volume;
  final String type;
  final String? owner;
  final String? status;

  Vehicle({
    required this.id,
    required this.card,
    required this.brand,
    required this.color,
    required this.volume,
    required this.type,
    this.owner,
    this.status,
  });
}
