import 'package:fork_up/domain/home/entity/product_entity.dart';

class CartEntity {
  final ProductEntity product;
  final int quantity;

  const CartEntity({
    required this.product,
    this.quantity = 1,
  });

  CartEntity copyWith({
    ProductEntity? product,
    int? quantity,
  }) {
    return CartEntity(
      product: product ?? this.product,
      quantity: quantity ?? this.quantity,
    );
  }
}