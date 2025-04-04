// mine.dart
class Mine {
  final int id;
  final String name;
  final String? authorizedDate;

  Mine({
    required this.id,
    required this.name,
    this.authorizedDate,
  });

  factory Mine.fromJson(Map<String, dynamic> json) {
    return Mine(
      id: json['id'],
      name: json['name'],
      authorizedDate: json['authorized_date'],
    );
  }
}
