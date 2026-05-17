import 'package:fork_up/domain/home/entity/product_entity.dart';
import 'package:hive/hive.dart';

part 'cart_product_entity.g.dart';

@HiveType(typeId: 1)
class CartProductEntity {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final double price;

  @HiveField(3)
  final String thumbnail;

  CartProductEntity({
    required this.id,
    required this.name,
    required this.price,
    required this.thumbnail,
  });

  factory CartProductEntity.fromProductEntity(ProductEntity entity) {
    return CartProductEntity(
      id: entity.id,
      name: entity.name,
      price: entity.priceAfterDiscount,
      thumbnail: entity.thumbnail,
    );
  }

  ProductEntity toProductEntity() {
    return ProductEntity(
      id: id,
      name: name,
      categoryIds: [],
      priceBeforeDiscount: price,
      priceAfterDiscount: price,
      thumbnail: thumbnail,
      images: [],
      inWishlist: false,
      slug: '',
      productStockCount: 0,
      discount: 0,
      isTaxable: false,
      variants: [],
    );
  }
}