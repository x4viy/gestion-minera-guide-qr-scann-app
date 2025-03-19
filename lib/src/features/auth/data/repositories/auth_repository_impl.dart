import 'package:fpdart/fpdart.dart';
import 'package:loadin_guide_scann/src/core/common/entities/user.dart';
import 'package:loadin_guide_scann/src/core/error/exceptions.dart';
import 'package:loadin_guide_scann/src/core/error/failures.dart';
import 'package:loadin_guide_scann/src/core/network/connection_checker.dart';
import 'package:loadin_guide_scann/src/core/secrets/app_secrets.dart';
import 'package:loadin_guide_scann/src/core/utils/constants/variables_constat.dart';
import 'package:loadin_guide_scann/src/features/auth/data/datasources/remote/auth_remote_data_source.dart';
import 'package:loadin_guide_scann/src/features/auth/data/models/session_model.dart';
import 'package:loadin_guide_scann/src/features/auth/domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final ConnectionChecker connectionChecker;
  final AppSecretsService appSecretsService;
  const AuthRepositoryImpl(
    this.remoteDataSource,
    this.connectionChecker,
    this.appSecretsService,
  );

  @override
  Future<Either<Failure, User>> loginWithCiPassword({
    required String ci,
    required String password,
  }) async {
    return _getUser(
      () async => await remoteDataSource.loginWithCiPassword(
        ci: ci,
        password: password,
      ),
    );
  }

  Future<Either<Failure, User>> _getUser(
    Future<Session> Function() fn,
  ) async {
    try {
      if (!await (connectionChecker.isConnected)) {
        return left(const NoInternetConnectionFailure());
      }

      final session = await fn();

      if (session.token == null) {
        logger.e('❌ Failed to login: no token received.');
        return left(const ServerFailure('No authorizado', 401));
      }
      await appSecretsService.setSession(session);
      return right(session.user as User);
    } on ServerException catch (e) {
      return left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, User>> currentUser() async {
    // checkar aqui el local storage y expiracion del token
    try {
      final token = await appSecretsService.getToken();
      if (token == null) {
        return left(const RetrieveToken('No existe inicio de sesión previo'));
      }

      final user = await appSecretsService.getUser();

      return right(user);
    } catch (e) {
      return left(RetrieveToken('No se pudo recuperar credenciales'));
    }
  }
}
