import '../repository/auth_repo.dart';

class RemoveTokenUseCase {
  final AuthRepo repo;

  RemoveTokenUseCase(this.repo);

  Future<void> call() async {
    await repo.removeToken();
  }
}
