import 'package:fork_up/data/home/model/product_model.dart';

abstract class RecentlyViewedLocalDataSource {
  Future<List<Product>> getProducts();
  Future<void> addProducts(List<Product> products);
  Future<void> clear();
}
