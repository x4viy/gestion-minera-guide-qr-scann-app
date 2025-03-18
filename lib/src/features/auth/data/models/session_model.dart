import 'package:pedidos/src/features/auth/data/models/user_model.dart';

class Session {
  final String accessToken;
  final String refreshToken;
  final UserModel user;
  final int expiresIn;
  final String tokenType;
  final String? providerToken;

  Session({
    required this.accessToken,
    required this.refreshToken,
    required this.user,
    required this.expiresIn,
    required this.tokenType,
    this.providerToken,
  });

  factory Session.fromJson(Map<String, dynamic> json) {
    return Session(
      accessToken: json['accessToken'],
      refreshToken: json['refreshToken'],
      user: UserModel.fromJson(json['user']),
      expiresIn: json['expiresIn'],
      tokenType: json['tokenType'],
      providerToken: json['providerToken'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'accessToken': accessToken,
      'refreshToken': refreshToken,
      'user': user.toJson(),
      'expiresIn': expiresIn,
      'tokenType': tokenType,
      'providerToken': providerToken,
    };
  }
}
