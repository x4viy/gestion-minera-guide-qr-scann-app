import 'package:fpdart/fpdart.dart';
import 'package:pedidos/src/core/common/entities/user.dart';
import 'package:pedidos/src/core/error/exceptions.dart';
import 'package:pedidos/src/core/error/failures.dart';
import 'package:pedidos/src/core/network/connection_checker.dart';
import 'package:pedidos/src/features/auth/data/datasources/remote/auth_remote_data_source.dart';
import 'package:pedidos/src/features/auth/domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final ConnectionChecker connectionChecker;
  const AuthRepositoryImpl(
    this.remoteDataSource,
    this.connectionChecker,
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
    Future<User> Function() fn,
  ) async {
    try {
      if (!await (connectionChecker.isConnected)) {
        return left(const NoInternetConnectionFailure());
      }
      final user = await fn();

      return right(user);
    } on ServerException catch (e) {
      return left(ServerFailure(e.message, e.statusCode));
    }
  }

  // @override
  // Future<Either<Failure, User>> signUpWithEmailPassword({
  //   required String name,
  //   required String email,
  //   required String password,
  // }) async {
  //   return _getUser(
  //     () async => await remoteDataSource.signUpWithEmailPassword(
  //       name: name,
  //       email: email,
  //       password: password,
  //     ),
  //   );
  // }

  Future<Either<Failure, User>> currentUser() async {
    // try {
    //   if (!await (connectionChecker.isConnected)) {
    //     final session = remoteDataSource.currentUserSession;

    //     if (session == null) {
    //       return left(Failure('User not logged in!'));
    //     }

    //     return right(
    //       UserModel(
    //         id: session.user.id,
    //         email: session.user.email ?? '',
    //         name: '',
    //       ),
    //     );
    //   }
    //   final user = await remoteDataSource.getCurrentUserData();
    //   if (user == null) {
    //     return left(Failure('User not logged in!'));
    //   }

    //   return right(user);
    // } on ServerException catch (e) {
    //   return left(Failure(e.message));
    // }
    throw UnimplementedError();
  }
}
