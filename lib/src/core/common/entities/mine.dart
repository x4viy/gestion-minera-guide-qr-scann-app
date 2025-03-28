import 'package:loadin_guide_scann/src/core/common/entities/material.dart';

class Mine {
  final int id;
  final String name;
  final String authorizedDate;
  final List<MaterialMine>? materials;
  final String? status;

  const Mine({
    required this.id,
    required this.name,
    required this.authorizedDate,
    this.materials,
    this.status,
  });
}
