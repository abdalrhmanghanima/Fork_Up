import 'package:fork_up/domain/home/entity/product_entity.dart';
import 'package:fork_up/domain/wish_list/repository/wish_list_repo.dart';

class ToggleWishListUseCase {
  final WishListRepo repo;

  ToggleWishListUseCase(this.repo);

  Future<void> call(ProductEntity product) async {
    await repo.toggleWishList(product);
  }
}
