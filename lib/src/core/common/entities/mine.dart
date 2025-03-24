import 'material.dart';

class Mine {
  final int id;
  final String name;
  final String authorizedDate;
  final List<Material>? materials;
  final String? status;

  const Mine({
    required this.id,
    required this.name,
    required this.authorizedDate,
    this.materials,
    this.status,
  });
}
