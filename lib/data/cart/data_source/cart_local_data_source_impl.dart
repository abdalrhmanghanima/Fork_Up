import 'package:fork_up/data/cart/data_source/cart_local_data_source.dart';
import 'package:fork_up/data/cart/model/cart_model.dart';
import 'package:hive/hive.dart';

class CartLocalDataSourceImpl implements CartLocalDataSource{
  final Box<CartModel> cartBox;
  CartLocalDataSourceImpl(this.cartBox);
  @override
  Future<List<CartModel>> getCart() async{
    return cartBox.values.toList();
  }
  @override
  Future<void> addToCart(CartModel item) {
    return cartBox.put(item.product.id, item);
  }
  @override
  Future<void> removeFromCart(int productId) {
    return cartBox.delete(productId);
  }
  @override
  Future<void> clearCart() {
    return cartBox.clear();
  }
  @override
  Future<void> decreaseQuantity(int productId) async {
    final item = cartBox.get(productId);

    if (item == null) return;

    if (item.quantity > 1) {
      final updatedItem = item.copyWith(
        quantity: item.quantity - 1,
      );

      await cartBox.put(productId, updatedItem);
    } else {
      return;
    }
  }
}