import 'package:loadin_guide_scann/src/core/common/entities/user_system.dart';

class MiningOwner extends UserSystem {
  final String? institutionName;

  MiningOwner({
    required super.id,
    required super.name,
    required super.lastname,
    required super.numberIdentification,
    this.institutionName,
    String? email,
    super.password,
    super.status,
    super.isAdmin = false,
    super.role,
  }) : super(
          email: email ?? '',
        );

  factory MiningOwner.fromJson(Map<String, dynamic> json) {
    return MiningOwner(
      id: json['id'],
      name: json['name'],
      lastname: json['lastname'],
      numberIdentification: json['number_identification'],
      institutionName: json['institution_name'],
      email: json['email'],
    );
  }
}
