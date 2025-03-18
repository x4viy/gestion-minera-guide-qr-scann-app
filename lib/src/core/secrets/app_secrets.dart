import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AppSecretsService {
  late final FlutterSecureStorage _storage = FlutterSecureStorage();

  static const String _jwtKey = 'jwt';

  Future<String?> getToken() async {
    return await _storage.read(key: _jwtKey);
  }

  Future<void> setToken(String token) async {
    await _storage.write(key: _jwtKey, value: token);
  }

  Future<void> deleteToken() async {
    await _storage.delete(key: _jwtKey);
  }

  Future<void> clearStorage() async {
    await _storage.deleteAll();
  }
}
