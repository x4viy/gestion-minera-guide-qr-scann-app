import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:loadin_guide_scann/src/core/common/entities/user.dart';
import 'package:loadin_guide_scann/src/features/auth/data/models/session_model.dart';

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

  Future<void> setUser(User user) async {
    await _storage.write(key: 'id', value: user.id);
    await _storage.write(key: 'ci', value: user.ci);
  }

  Future<User> getUser() async {
    final id = await _storage.read(key: 'id');
    final ci = await _storage.read(key: 'ci');
    return User(id: id ?? '', ci: ci ?? '');
  }

  Future<void> setSession(Session s) async {
    await setToken(s.token!);
    await setUser(s.user!);
  }

  Future<void> clearSession() async {
    await deleteToken();
    await _storage.delete(key: 'id');
    await _storage.delete(key: 'ci');
  }
}
