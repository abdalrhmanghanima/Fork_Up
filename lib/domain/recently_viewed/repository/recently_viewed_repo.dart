

import 'package:fork_up/domain/home/entity/product_entity.dart';

abstract class RecentlyViewedRepository {
  Future<List<ProductEntity>> getRecentlyViewed();
  Future<void> addProduct(ProductEntity product);
  Future<void> clear();
}