import 'package:fork_up/domain/home/entity/variant_entity.dart';

class ProductEntity {
  final int id;
  final String name;
  final List<int> categoryIds;
  final double priceBeforeDiscount;
  final double priceAfterDiscount;
  final String thumbnail;
  final List<String> images;
  final bool inWishlist;
  final String slug;
  final int productStockCount;
  final double discount;
  final bool isTaxable;
  final List<VariantEntity> variants;

  ProductEntity({
    required this.id,
    required this.name,
    required this.categoryIds,
    required this.priceBeforeDiscount,
    required this.priceAfterDiscount,
    required this.thumbnail,
    required this.images,
    required this.inWishlist,
    required this.slug,
    required this.productStockCount,
    required this.discount,
    required this.isTaxable,
    required this.variants,
  });
}
