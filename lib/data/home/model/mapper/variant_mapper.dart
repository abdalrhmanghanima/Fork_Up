import 'package:fork_up/data/home/model/variant_model.dart';
import 'package:fork_up/domain/home/entity/variant_entity.dart';

extension VariantMapper on Variant {
  VariantEntity toEntity() {
    return VariantEntity(
      id: id,
      name: name,
      option: option,
      priceBeforeDiscount: priceBeforeDiscount.toDouble(),
      priceAfterDiscount: priceAfterDiscount.toDouble(),
      images: images,
      inWishlist: inWishlist,
    );
  }
}
