import 'package:fork_up/domain/product_details/entity/variation_entity.dart';

class VariationModel extends VariationEntity {
  const VariationModel({
    required super.id,
    required super.option,
    required super.priceBeforeDiscount,
    required super.priceAfterDiscount,
    required super.stock,
  });

  factory VariationModel.fromJson(Map<String, dynamic> json) {
    return VariationModel(
      id: json['id'],
      option: json['option'],
      priceBeforeDiscount:
      (json['price_before_discount'] as num).toDouble(),
      priceAfterDiscount:
      (json['price_after_discount'] as num).toDouble(),
      stock: json['product_stock_count'],
    );
  }
}