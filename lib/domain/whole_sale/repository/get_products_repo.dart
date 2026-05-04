import 'package:fork_up/domain/home/entity/product_entity.dart';

abstract class GetProductsRepo {
  Future<List<ProductEntity>> getProducts({int page =1});
}