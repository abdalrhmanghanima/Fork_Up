import 'package:fork_up/domain/product_details/entity/attribute_entity.dart';
import 'package:fork_up/domain/product_details/entity/buy_it_together_entity.dart';
import 'package:fork_up/domain/product_details/entity/related_product_entity.dart';

class ProductDetailsEntity {
  final int id;
  final String name;
  final List<int> categoryIds;
  final double priceBeforeDiscount;
  final double priceAfterDiscount;
  final String thumbnail;
  final List<String> images;
  final String description;
  final String shortDescription;
  final bool inWishlist;
  final String slug;
  final int stock;
  final double discount;
  final double rate;
  final bool isTaxable;
  final List<AttributeEntity> attributes;
  final List<RelatedProductEntity> relatedProducts;
  final List<BuyItTogetherEntity>? buyItTogether;

  const ProductDetailsEntity({
    required this.buyItTogether,
    required this.id,
    required this.name,
    required this.categoryIds,
    required this.priceBeforeDiscount,
    required this.priceAfterDiscount,
    required this.thumbnail,
    required this.images,
    required this.description,
    required this.shortDescription,
    required this.inWishlist,
    required this.slug,
    required this.stock,
    required this.discount,
    required this.rate,
    required this.isTaxable,
    required this.attributes,
    required this.relatedProducts,
  });
}
