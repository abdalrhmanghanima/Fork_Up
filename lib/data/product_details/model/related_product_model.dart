import 'package:fork_up/domain/product_details/entity/related_product_entity.dart';

class RelatedProductModel extends RelatedProductEntity {
  const RelatedProductModel({
    required super.id,
    required super.name,
    required super.thumbnail,
    required super.price,
  });

  factory RelatedProductModel.fromJson(Map<String, dynamic> json) {
    return RelatedProductModel(
      id: json['id'],
      name: json['name'],
      thumbnail: json['thumbnail'],
      price: (json['price_after_discount'] as num).toDouble(),
    );
  }
}
