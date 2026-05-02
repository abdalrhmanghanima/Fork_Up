import 'package:fork_up/data/product_details/model/attribute_model.dart';
import 'package:fork_up/data/product_details/model/buy_it_together_model.dart';
import 'package:fork_up/data/product_details/model/related_product_model.dart';
import 'package:fork_up/domain/product_details/entity/product_details_entity.dart';
class ProductDetailsModel extends ProductDetailsEntity {
  const ProductDetailsModel({
    required super.buyItTogether,
    required super.id,
    required super.name,
    required super.categoryIds,
    required super.priceBeforeDiscount,
    required super.priceAfterDiscount,
    required super.thumbnail,
    required super.images,
    required super.description,
    required super.shortDescription,
    required super.inWishlist,
    required super.slug,
    required super.stock,
    required super.discount,
    required super.rate,
    required super.isTaxable,
    required super.attributes,
    required super.relatedProducts,
  });

  // ===========================
  // FROM JSON
  // ===========================
  factory ProductDetailsModel.fromJson(Map<String, dynamic> json) {
    return ProductDetailsModel(
      buyItTogether: (json['buy_it_together'] as List? ?? [])
          .map((e) => BuyItTogetherModel.fromJson(e))
          .toList(),

      id: json['id'] ?? 0,

      name: json['name'] ?? '',

      categoryIds: (json['category_ids'] as List? ?? [])
          .map((e) => int.tryParse(e.toString()) ?? 0)
          .toList(),

      priceBeforeDiscount:
      (json['price_before_discount'] as num?)?.toDouble() ?? 0,

      priceAfterDiscount:
      (json['price_after_discount'] as num?)?.toDouble() ?? 0,

      thumbnail: json['thumbnail'] ?? '',

      images: (json['images'] as List? ?? [])
          .map((e) => e.toString())
          .toList(),

      description: json['description'] ?? '',

      shortDescription: json['short_description'] ?? '',

      inWishlist: json['in_wishlist'] ?? false,

      slug: json['slug'] ?? '',

      stock: json['product_stock_count'] ?? 0,

      discount: (json['discount'] as num?)?.toDouble() ?? 0,

      rate: (json['rate'] as num?)?.toDouble() ?? 0,

      isTaxable: json['is_taxable'] ?? false,

      attributes: (json['attributes'] as List? ?? [])
          .map((e) => AttributeModel.fromJson(e))
          .toList(),

      relatedProducts: (json['related_ids'] as List? ?? [])
          .map((e) => RelatedProductModel.fromJson(e))
          .toList(),
    );
  }

  // ===========================
  // TO JSON
  // ===========================
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'category_ids': categoryIds,
      'price_before_discount': priceBeforeDiscount,
      'price_after_discount': priceAfterDiscount,
      'thumbnail': thumbnail,
      'images': images,
      'description': description,
      'short_description': shortDescription,
      'in_wishlist': inWishlist,
      'slug': slug,
      'product_stock_count': stock,
      'discount': discount,
      'rate': rate,
      'is_taxable': isTaxable,

      // 🔥 سيبهم فاضيين
      'attributes': [],
      'related_ids': [],
      'buy_it_together': [],
    };
  }
  // ===========================
  // FROM ENTITY 🔥
  // ===========================
  factory ProductDetailsModel.fromEntity(ProductDetailsEntity e) {
    return ProductDetailsModel(
      buyItTogether: e.buyItTogether,
      id: e.id,
      name: e.name,
      categoryIds: e.categoryIds,
      priceBeforeDiscount: e.priceBeforeDiscount,
      priceAfterDiscount: e.priceAfterDiscount,
      thumbnail: e.thumbnail,
      images: e.images,
      description: e.description,
      shortDescription: e.shortDescription,
      inWishlist: e.inWishlist,
      slug: e.slug,
      stock: e.stock,
      discount: e.discount,
      rate: e.rate,
      isTaxable: e.isTaxable,
      attributes: e.attributes,
      relatedProducts: e.relatedProducts,
    );
  }

  // ===========================
  // TO ENTITY
  // ===========================
  ProductDetailsEntity toEntity() {
    return ProductDetailsEntity(
      buyItTogether: buyItTogether,
      id: id,
      name: name,
      categoryIds: categoryIds,
      priceBeforeDiscount: priceBeforeDiscount,
      priceAfterDiscount: priceAfterDiscount,
      thumbnail: thumbnail,
      images: images,
      description: description,
      shortDescription: shortDescription,
      inWishlist: inWishlist,
      slug: slug,
      stock: stock,
      discount: discount,
      rate: rate,
      isTaxable: isTaxable,
      attributes: attributes,
      relatedProducts: relatedProducts,
    );
  }
  ProductDetailsEntity toDetailsEntity() {
    return ProductDetailsEntity(
      id: id,
      name: name,
      categoryIds: [],
      priceBeforeDiscount: priceBeforeDiscount,
      priceAfterDiscount: priceBeforeDiscount,
      thumbnail: thumbnail,
      images: [],
      description: '',
      shortDescription: '',
      inWishlist: false,
      slug: slug,
      stock: 0,
      discount: 0,
      rate: 0,
      isTaxable: false,
      attributes: [],
      relatedProducts: [],
      buyItTogether: [],
    );
  }}