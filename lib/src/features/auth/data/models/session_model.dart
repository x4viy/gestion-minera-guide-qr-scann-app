import 'package:loadin_guide_scann/src/features/auth/data/models/user_model.dart';

class Session {
  final String? message;
  final int? expiresIn;
  final String? token;
  final String? refreshToken;
  UserModel? user;
  final String? tokenType;
  final String? providerToken;

  Session({
    this.message,
    this.token,
    this.refreshToken,
    this.user,
    this.expiresIn,
    this.tokenType,
    this.providerToken,
  });

  factory Session.fromJson(Map<String, dynamic> json) {
    return Session(
      token: json['token'],
      refreshToken: json['refreshToken'],
      user: json['user'] != null ? UserModel.fromJson(json['user']) : null,
      expiresIn: json['expiresIn'],
      tokenType: json['tokenType'],
      providerToken: json['providerToken'],
      message: json['message'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'token': token,
      'refreshToken': refreshToken,
      'user': user?.toJson(),
      'expiresIn': expiresIn,
      'tokenType': tokenType,
      'providerToken': providerToken,
    };
  }
}
