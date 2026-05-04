import 'package:fork_up/domain/home/entity/product_entity.dart';

class CartEntity {
  final ProductEntity product;
  int quantity;

  CartEntity({
    required this.product,
    this.quantity = 1,
  });
  CartEntity copyWith({
    int? quantity,
  }) {
    return CartEntity(
      product: product,
      quantity: quantity ?? this.quantity,
    );
  }
}