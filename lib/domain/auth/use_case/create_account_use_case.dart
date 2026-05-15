import 'package:fork_up/domain/auth/entity/register_entity.dart';
import 'package:fork_up/domain/auth/repository/auth_repo.dart';

class CreateAccountUseCase {
  final AuthRepo authRepo;
  CreateAccountUseCase(this.authRepo);
  Future<RegisterEntity> call({
    required String phone,
    required String firstName,
    required String lastName,
  }) {
    return authRepo.createAccount(
      phone: phone,
      firstName: firstName,
      lastName: lastName,
    );
  }
}
