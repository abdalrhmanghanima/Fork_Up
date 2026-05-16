import 'package:fork_up/data/home/model/data_model.dart';
import 'package:fork_up/domain/home/entity/data_entity.dart';
import 'category_mapper.dart';
import 'partner_mapper.dart';
import 'offer_mapper.dart';

extension DataMapper on Data {
  DataEntity toEntity() {
    return DataEntity(
      bannerImage: bannerImage,
      cartCount: cartCount,
      categories: categories.map((e) => e.toEntity()).toList(),
      newArrivalProducts: newArrivalProducts.map((e) => e.toEntity()).toList(),
      bestSellers: bestSellers.map((e) => e.toEntity()).toList(),
      partners: partners.map((e) => e.toEntity()).toList(),
      offers: offers.map((e) => e.toEntity()).toList(),
    );
  }
}
