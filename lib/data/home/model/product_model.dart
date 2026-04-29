import 'package:fork_up/data/home/model/variant_model.dart';

class Product {
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
  final List<Variant> variants;

  Product({
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

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      categoryIds: List<int>.from(json['category_ids']),
      priceBeforeDiscount: (json['price_before_discount']).toDouble(),
      priceAfterDiscount: (json['price_after_discount']).toDouble(),
      thumbnail: json['thumbnail'],
      images: List<String>.from(json['images']),
      inWishlist: json['in_wishlist'],
      slug: json['slug'],
      productStockCount: json['product_stock_count'],
      discount: (json['discount']).toDouble(),
      isTaxable: json['is_taxable'],
      variants: (json['variants'] as List)
          .map((e) => Variant.fromJson(e))
          .toList(),
    );
  }
}