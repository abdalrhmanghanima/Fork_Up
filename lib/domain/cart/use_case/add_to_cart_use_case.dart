import 'package:fork_up/domain/cart/repository/cart_repo.dart';
import 'package:fork_up/domain/home/entity/product_entity.dart';

class AddToCartUseCase {
  final CartRepository repo;

  AddToCartUseCase(this.repo);

  Future<void> call(ProductEntity product, {int quantity = 1}) async {
    await repo.addToCart(product, quantity: quantity);
  }
}
