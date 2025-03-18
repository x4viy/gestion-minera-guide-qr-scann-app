import 'package:pedidos/src/core/common/entities/user.dart';

class UserModel extends User {
  UserModel({
    super.id,
    required super.ci,
    required super.name,
  });

  factory UserModel.fromJson(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] ?? '',
      ci: map['ci'] ?? '',
      name: map['name'] ?? '',
    );
  }

  UserModel copyWith({
    String? id,
    String? ci,
    String? name,
  }) {
    return UserModel(
      id: id ?? this.id,
      ci: ci ?? this.ci,
      name: name ?? this.name,
    );
  }

  // imlement the toJson method
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'ci': ci,
      'name': name,
    };
  }
}
