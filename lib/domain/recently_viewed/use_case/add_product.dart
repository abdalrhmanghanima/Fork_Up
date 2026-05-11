import 'package:fork_up/domain/home/entity/product_entity.dart';
import 'package:fork_up/domain/recently_viewed/repository/recently_viewed_repo.dart';

class AddRecentlyViewedUseCase {
  final RecentlyViewedRepository repo;

  AddRecentlyViewedUseCase(this.repo);

  Future<void> call(ProductEntity product) async {
    await repo.addProduct(product);
  }
}