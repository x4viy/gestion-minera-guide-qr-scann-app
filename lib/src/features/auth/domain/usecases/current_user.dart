import 'package:fpdart/fpdart.dart';
import 'package:loadin_guide_scann/src/core/common/entities/user.dart';
import 'package:loadin_guide_scann/src/core/error/failures.dart';
import 'package:loadin_guide_scann/src/core/secrets/app_secrets.dart';
import 'package:loadin_guide_scann/src/core/usecase/usecase.dart';
import 'package:loadin_guide_scann/src/features/auth/domain/repository/auth_repository.dart';

class CurrentUser implements UseCase<User, NoParams> {
  final AuthRepository authRepository;
  final AppSecretsService appSecretsService;
  CurrentUser(this.authRepository, this.appSecretsService);

  @override
  Future<Either<Failure, User>> call(NoParams params) async {
    return await authRepository.currentUser();
  }
}
