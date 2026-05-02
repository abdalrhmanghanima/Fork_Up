import 'package:fork_up/domain/product_details/entity/related_product_entity.dart';

class BuyItTogetherEntity {
  final int buyTogetherId;
  final List<RelatedProductEntity> products;

  BuyItTogetherEntity({
    required this.buyTogetherId,
    required this.products,
  });
}