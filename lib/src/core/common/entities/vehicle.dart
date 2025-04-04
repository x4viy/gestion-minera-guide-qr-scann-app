// vehicle.dart
class Vehicle {
  final int id;
  final String? card;
  final String? brand;
  final String? color;
  final int? volume;
  final String? type;
  final String? owner;
  final String? status;

  Vehicle({
    required this.id,
    this.card,
    this.brand,
    this.color,
    this.volume,
    this.type,
    this.owner,
    this.status,
  });

  factory Vehicle.fromJson(Map<String, dynamic> json) {
    return Vehicle(
      id: json['id'],
      card: json['card'],
      brand: json['brand'],
      color: json['color'],
      volume: json['volume'],
      type: json['type'],
      owner: json['owner'],
      status: json['status'],
    );
  }
}
