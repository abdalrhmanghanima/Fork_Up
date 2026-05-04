import 'package:fork_up/domain/home/entity/best_seller_entity.dart';

import 'product_model.dart';

class BestSellerModel extends BestSellerEntity {
  BestSellerModel({
    required super.products,
  });

  factory BestSellerModel.fromJson(List<dynamic> json) {
    return BestSellerModel(
      products: json
          .map((e) => Product.fromJson(e).toEntity())
          .toList(),
    );
  }
}