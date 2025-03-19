part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

class AppStarted extends AuthEvent {}

final class AuthLogin extends AuthEvent {
  final String ci;
  final String password;

  AuthLogin({
    required this.ci,
    required this.password,
  });
}

final class AuthIsUserLoggedIn extends AuthEvent {}

class AuthLoggedOut extends AuthEvent {}

class TokenExpired extends AuthEvent {}
