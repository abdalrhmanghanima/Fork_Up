import '../repository/auth_repo.dart';

class StoreFcmTokenUseCase {
  final AuthRepo repo;

  StoreFcmTokenUseCase(this.repo);

  Future<void> call() {
    return repo.storeFcmToken();
  }
}
