import 'package:fork_up/data/home/model/category_model.dart';
import 'package:fork_up/data/home/model/offer_model.dart';
import 'package:fork_up/data/home/model/partner_model.dart';
import 'package:fork_up/data/home/model/product_model.dart';

class Data {
  final String bannerImage;
  final int cartCount;
  final List<CategoryModel> categories;
  final List<Product> newArrivalProducts;
  final List<Product> bestSellers;
  final List<Partner> partners;
  final List<Offer> offers;

  Data({
    required this.bannerImage,
    required this.cartCount,
    required this.categories,
    required this.newArrivalProducts,
    required this.bestSellers,
    required this.partners,
    required this.offers,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      bannerImage: json['banner_image'],
      cartCount: json['cart_count'],
      categories: (json['categories'] as List)
          .map((e) => CategoryModel.fromJson(e))
          .toList(),
      newArrivalProducts: (json['new_arrival_products'] as List)
          .map((e) => Product.fromJson(e))
          .toList(),
      bestSellers: (json['best_sellers'] as List)
          .map((e) => Product.fromJson(e))
          .toList(),
      partners: (json['partners'] as List)
          .map((e) => Partner.fromJson(e))
          .toList(),
      offers: (json['offers'] as List)
          .map((e) => Offer.fromJson(e))
          .toList(),
    );
  }
}