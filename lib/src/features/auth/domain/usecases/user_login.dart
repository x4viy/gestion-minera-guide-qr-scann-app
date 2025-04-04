import 'package:fpdart/fpdart.dart';
import 'package:loadin_guide_scann/src/core/common/entities/user.dart';
import 'package:loadin_guide_scann/src/core/error/failures.dart';
import 'package:loadin_guide_scann/src/core/usecase/usecase.dart';
import 'package:loadin_guide_scann/src/features/auth/domain/repository/auth_repository.dart';

class UserLogin implements UseCase<User, UserLoginParams> {
  final AuthRepository authRepository;

  const UserLogin(this.authRepository);

  @override
  Future<Either<Failure, User>> call(UserLoginParams params) async {
    return await authRepository.loginWithCiPassword(
      ci: params.ci,
      password: params.password,
    );
  }
}

class UserLoginParams {
  final String ci;
  final String password;

  UserLoginParams({
    required this.ci,
    required this.password,
  });
}
