import 'package:fork_up/domain/home/entity/product_entity.dart';
import 'package:fork_up/domain/wish_list/repository/wish_list_repo.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: WishListRepo)
class WishListRepositoryImpl implements WishListRepo {
  final List<ProductEntity> _cart = [];

  @override
  Future<List<ProductEntity>> getWishList() async {
    return List.from(_cart);
  }

  @override
  Future<void> toggleWishList(ProductEntity product) async {
    final index = _cart.indexWhere((e) => e.id == product.id);

    if (index == -1) {
      _cart.add(product);
    } else {
      _cart.removeAt(index);
    }
  }

  @override
  Future<void> clear() async {
    _cart.clear();
  }
}
