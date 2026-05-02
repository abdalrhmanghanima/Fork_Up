import 'package:fork_up/domain/home/entity/product_entity.dart';
import 'package:fork_up/domain/recently_viewed/repository/recently_viewed_repo.dart';
import 'package:injectable/injectable.dart';
@lazySingleton
class GetRecentlyViewedUseCase {
  final RecentlyViewedRepository repo;

  GetRecentlyViewedUseCase(this.repo);

  Future<List<ProductEntity>> call() async {
    return await repo.getRecentlyViewed();
  }
}