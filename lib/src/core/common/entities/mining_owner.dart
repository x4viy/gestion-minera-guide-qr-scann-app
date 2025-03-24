import 'package:loadin_guide_scann/src/core/common/entities/user_system.dart';

class MiningOwner extends UserSystem {
  final String direction;
  final String? institutionName;

  MiningOwner({
    required this.direction,
    this.institutionName,
    required super.id,
    required super.name,
    required super.lastname,
    required super.email,
    required super.numberIdentification,
    super.password,
    super.status,
    super.isAdmin = false,
    super.role,
  });
}
