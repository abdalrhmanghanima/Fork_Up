import 'package:fork_up/domain/home/entity/product_entity.dart';
import 'package:fork_up/domain/product_details/entity/product_details_entity.dart';

extension ProductDetailsMapper on ProductDetailsEntity {
  ProductEntity toProduct() {
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
      productStockCount: stock,
      discount: discount,
      isTaxable: isTaxable,
      variants: [],
    );
  }
}
