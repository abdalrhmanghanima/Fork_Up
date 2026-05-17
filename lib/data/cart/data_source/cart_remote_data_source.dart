import 'package:fork_up/domain/cart/entity/cart_entity.dart';

abstract class CartRemoteDataSource {
  Future<void> addToCart({
    required int productId,
    required int quantity,
    int? variantId,
  });
  Future<List<CartEntity>> getCart();

}