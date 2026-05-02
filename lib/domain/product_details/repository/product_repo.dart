import 'package:fork_up/domain/product_details/entity/product_details_entity.dart';

abstract class ProductRepo {
  Future<ProductDetailsEntity> getProductDetails(String slug);
}
