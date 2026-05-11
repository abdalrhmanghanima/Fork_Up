import 'package:fork_up/domain/recently_viewed/repository/recently_viewed_repo.dart';

class ClearRecentlyViewedUseCase {
  final RecentlyViewedRepository repo;

  ClearRecentlyViewedUseCase(this.repo);

  Future<void> call() async {
    await repo.clear();
  }
}