import 'package:fork_up/domain/cart/entity/cart_entity.dart';
import 'package:fork_up/domain/cart/entity/cart_product_entity.dart';
import 'package:hive/hive.dart';


part 'cart_model.g.dart';

@HiveType(typeId: 0)
class CartModel extends HiveObject {
  @HiveField(0)
  final CartProductEntity product;

  @HiveField(1)
  final int quantity;

  CartModel({
    required this.product,
    required this.quantity,
  });

  factory CartModel.fromEntity(CartEntity entity) {
    return CartModel(
      product: CartProductEntity.fromProductEntity(entity.product),
      quantity: entity.quantity,
    );
  }

  CartEntity toEntity() {
    return CartEntity(
      product: product.toProductEntity(),
      quantity: quantity,
    );
  }

  CartModel copyWith({
    CartProductEntity? product,
    int? quantity,
  }) {
    return CartModel(
      product: product ?? this.product,
      quantity: quantity ?? this.quantity,
    );
  }
}