import 'package:fork_up/data/home/model/variant_model.dart';
import 'package:fork_up/domain/home/entity/product_entity.dart';

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
      categoryIds: List<int>.from(json['category_ids'] ?? []),
      priceBeforeDiscount: (json['price_before_discount']).toDouble(),
      priceAfterDiscount: (json['price_after_discount']).toDouble(),
      thumbnail: json['thumbnail'],
      images: List<String>.from(json['images'] ?? []),
      inWishlist: json['in_wishlist'],
      slug: json['slug'],
      productStockCount: json['product_stock_count'],
      discount: (json['discount']).toDouble(),
      isTaxable: json['is_taxable'],
      variants: (json['variants'] as List? ?? [])
          .map((e) => Variant.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'category_ids': categoryIds,
      'price_before_discount': priceBeforeDiscount,
      'price_after_discount': priceAfterDiscount,
      'thumbnail': thumbnail,
      'images': images,
      'in_wishlist': inWishlist,
      'slug': slug,
      'product_stock_count': productStockCount,
      'discount': discount,
      'is_taxable': isTaxable,
      'variants': [],
    };
  }

  factory Product.fromEntity(ProductEntity e) {
    return Product(
      id: e.id,
      name: e.name,
      categoryIds: e.categoryIds,
      priceBeforeDiscount: e.priceBeforeDiscount,
      priceAfterDiscount: e.priceAfterDiscount,
      thumbnail: e.thumbnail,
      images: e.images,
      inWishlist: e.inWishlist,
      slug: e.slug,
      productStockCount: e.productStockCount,
      discount: e.discount,
      isTaxable: e.isTaxable,
      variants: [],
    );
  }

  ProductEntity toEntity() {
    return ProductEntity(
      id: id,
      name: name,
      categoryIds: categoryIds,
      priceBeforeDiscount: priceBeforeDiscount,
      priceAfterDiscount: priceAfterDiscount,
      thumbnail: thumbnail,
      images: images,
      inWishlist: inWishlist,
      slug: slug,
      productStockCount: productStockCount,
      discount: discount,
      isTaxable: isTaxable,
      variants: [],
    );
  }
}