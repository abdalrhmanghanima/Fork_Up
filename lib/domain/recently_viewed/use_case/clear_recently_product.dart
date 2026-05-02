import 'package:fork_up/domain/recently_viewed/repository/recently_viewed_repo.dart';
import 'package:injectable/injectable.dart';
@lazySingleton
class ClearRecentlyViewedUseCase {
  final RecentlyViewedRepository repo;

  ClearRecentlyViewedUseCase(this.repo);

  Future<void> call() async {
    await repo.clear();
  }
}