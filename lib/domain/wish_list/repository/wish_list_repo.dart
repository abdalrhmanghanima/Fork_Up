import 'package:fork_up/domain/home/entity/product_entity.dart';

abstract class WishListRepo {
  Future<List<ProductEntity>> getWishList();
  Future<void> toggleWishList(ProductEntity product);

  Future<void> clear();
}
