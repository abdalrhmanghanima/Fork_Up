import 'package:fork_up/domain/cart/entity/cart_entity.dart';
import 'package:fork_up/domain/home/entity/product_entity.dart';

abstract class CartRepository {
  Future<List<CartEntity>> getCart();
  Future<void> addToCart(ProductEntity product, {int quantity = 1});
  Future<void> removeFromCart(ProductEntity product);
  Future<void> clear();
}
