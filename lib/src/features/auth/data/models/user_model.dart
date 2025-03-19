import 'package:loadin_guide_scann/src/core/common/entities/user.dart';

class UserModel extends User {
  UserModel({
    super.id,
    required super.ci,
  });

  factory UserModel.fromJson(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] ?? '',
      ci: map['ci'] ?? '',
    );
  }

  UserModel copyWith({
    String? id,
    String? ci,
  }) {
    return UserModel(
      id: id ?? this.id,
      ci: ci ?? this.ci,
    );
  }

  // imlement the toJson method
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'ci': ci,
    };
  }
}
