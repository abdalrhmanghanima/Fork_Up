import 'package:fork_up/data/home/model/offer_model.dart';
import 'package:fork_up/domain/home/entity/offer_entity.dart';

extension OfferMapper on Offer {
  OfferEntity toEntity() {
    return OfferEntity(
      id: id,
      url: url,
      type: type,
      slug: slug,
      categoryId: categoryId,
      categoryName: categoryName,
    );
  }
}