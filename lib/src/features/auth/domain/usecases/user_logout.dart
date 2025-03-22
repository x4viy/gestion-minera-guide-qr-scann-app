import 'package:fpdart/fpdart.dart';
import 'package:loadin_guide_scann/src/core/error/failures.dart';
import 'package:loadin_guide_scann/src/core/usecase/usecase.dart';
import 'package:loadin_guide_scann/src/features/auth/domain/repository/auth_repository.dart';

class UserLogout implements UseCase<NoParams, NoParams> {
  final AuthRepository authRepository;

  const UserLogout(this.authRepository);

  @override
  Future<Either<Failure, NoParams>> call(NoParams params) async {
    return await authRepository.logout();
  }
}
