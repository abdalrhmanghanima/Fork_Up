import 'package:fork_up/domain/cart/entity/cart_entity.dart';
import 'package:fork_up/domain/cart/repository/cart_repo.dart';
import 'package:fork_up/domain/home/entity/product_entity.dart';
class CartRepositoryImpl
    implements CartRepository {
  final List<CartEntity> _cart = [];

  @override
  Future<List<CartEntity>> getCart() async {
    return _cart;
  }
  @override
  Future<void> addToCart(ProductEntity product, {int quantity = 1}) async {
    final index = _cart.indexWhere((e) => e.product.id == product.id);

    if (index != -1) {
      _cart[index] = _cart[index].copyWith(
        quantity: _cart[index].quantity + quantity,
      );
    } else {
      _cart.add(
        CartEntity(
          product: product,
          quantity: quantity,
        ),
      );
    }
  }
  @override
  Future<void> removeFromCart(ProductEntity product) async {
    _cart.removeWhere((e) => e.product.id == product.id);
  }
  @override
  Future<void> clear() async {
     _cart.clear();
  }
}