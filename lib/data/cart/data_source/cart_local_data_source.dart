import 'package:fork_up/data/cart/model/cart_model.dart';

abstract class CartLocalDataSource{
  Future<List<CartModel>> getCart();
  Future<void> addToCart(CartModel item);
  Future<void> removeFromCart(int productId);
  Future<void> clearCart();
  Future<void> decreaseQuantity(int productId);
}