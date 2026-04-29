import 'package:fork_up/domain/home/entity/category_entity.dart';
import 'package:fork_up/domain/home/entity/offer_entity.dart';
import 'package:fork_up/domain/home/entity/partner_entity.dart';
import 'package:fork_up/domain/home/entity/product_entity.dart';

class DataEntity {
  final String bannerImage;
  final int cartCount;
  final List<CategoryEntity> categories;
  final List<ProductEntity> newArrivalProducts;
  final List<ProductEntity> bestSellers;
  final List<PartnerEntity> partners;
  final List<OfferEntity> offers;

  DataEntity({
    required this.bannerImage,
    required this.cartCount,
    required this.categories,
    required this.newArrivalProducts,
    required this.bestSellers,
    required this.partners,
    required this.offers,
  });
}