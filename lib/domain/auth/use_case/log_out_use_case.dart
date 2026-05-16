import 'package:fork_up/domain/auth/repository/auth_repo.dart';

class LogoutUseCase {
  final AuthRepo repo;

  LogoutUseCase(this.repo);

  Future<void> call() {
    return repo.logout();
  }
}
