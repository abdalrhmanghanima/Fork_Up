import 'package:fork_up/data/product_details/model/related_product_model.dart';
import 'package:fork_up/domain/product_details/entity/buy_it_together_entity.dart';

class BuyItTogetherModel extends BuyItTogetherEntity {
  BuyItTogetherModel({required super.buyTogetherId, required super.products});

  factory BuyItTogetherModel.fromJson(Map<String, dynamic> json) {
    return BuyItTogetherModel(
      buyTogetherId: json['buy_together_id'],
      products: List.from(
        json['_woodmart_fbt_products'],
      ).map((e) => RelatedProductModel.fromJson(e)).toList(),
    );
  }
}
