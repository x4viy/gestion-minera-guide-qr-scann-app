import 'package:fpdart/fpdart.dart';
import 'package:pedidos/src/core/common/entities/user.dart';
import 'package:pedidos/src/core/error/failures.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, User>> loginWithCiPassword({
    required String ci,
    required String password,
  });
  Future<Either<Failure, User>> currentUser();
}
