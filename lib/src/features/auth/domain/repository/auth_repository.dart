import 'package:fpdart/fpdart.dart';
import 'package:loadin_guide_scann/src/core/common/entities/user.dart';
import 'package:loadin_guide_scann/src/core/error/failures.dart';
import 'package:loadin_guide_scann/src/core/usecase/usecase.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, User>> loginWithCiPassword({
    required String ci,
    required String password,
  });
  Future<Either<Failure, User>> currentUser();
  Future<Either<Failure, NoParams>> logout();
}
