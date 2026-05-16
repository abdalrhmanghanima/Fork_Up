import 'package:fork_up/data/home/model/product_model.dart';
import 'package:fork_up/domain/home/entity/product_entity.dart';
import 'variant_mapper.dart';

extension ProductMapper on Product {
  ProductEntity toEntity() {
    return ProductEntity(
      id: id,
      name: name,
      categoryIds: categoryIds,
      priceBeforeDiscount: priceBeforeDiscount.toDouble(),
      priceAfterDiscount: priceAfterDiscount.toDouble(),
      thumbnail: thumbnail,
      images: images,
      inWishlist: inWishlist,
      slug: slug,
      productStockCount: productStockCount,
      discount: discount.toDouble(),
      isTaxable: isTaxable,
      variants: variants.map((e) => e.toEntity()).toList(),
    );
  }
}
