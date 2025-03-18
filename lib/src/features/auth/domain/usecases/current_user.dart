import 'package:fpdart/fpdart.dart';
import 'package:pedidos/src/core/common/entities/user.dart';
import 'package:pedidos/src/core/error/failures.dart';
import 'package:pedidos/src/core/usecase/usecase.dart';
import 'package:pedidos/src/features/auth/domain/repository/auth_repository.dart';

class CurrentUser implements UseCase<User, NoParams> {
  final AuthRepository authRepository;
  CurrentUser(this.authRepository);

  @override
  Future<Either<Failure, User>> call(NoParams params) async {
    return await authRepository.currentUser();
  }
}
