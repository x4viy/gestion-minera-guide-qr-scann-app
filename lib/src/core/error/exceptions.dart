class ServerException implements Exception {
  final String message;
  final int? statusCode;

  ServerException(this.message, this.statusCode);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }
    if (other is ServerException) {
      return other.message == message && other.statusCode == statusCode;
    }

    return false;
  }
}

class AuthException implements Exception {
  final String message;

  AuthException(this.message);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }
    if (other is AuthException) {
      return other.message == message;
    }

    return false;
  }
}
