import 'package:fork_up/domain/home/entity/product_entity.dart';
import 'package:fork_up/domain/wish_list/repository/wish_list_repo.dart';

class GetWishListUseCase {
  final WishListRepo repo;

  GetWishListUseCase(this.repo);

  Future<List<ProductEntity>> call() async {
    return await repo.getWishList();
  }
}
