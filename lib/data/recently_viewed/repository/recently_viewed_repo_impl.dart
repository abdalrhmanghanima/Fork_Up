import 'package:fork_up/data/home/model/product_model.dart';
import 'package:fork_up/data/recently_viewed/data_source/recently_local_data_source.dart';
import 'package:fork_up/domain/home/entity/product_entity.dart';
import 'package:fork_up/domain/recently_viewed/repository/recently_viewed_repo.dart';
class RecentlyViewedRepositoryImpl
    implements RecentlyViewedRepository {
  final RecentlyViewedLocalDataSource local;

  RecentlyViewedRepositoryImpl(this.local);

  @override
  Future<List<ProductEntity>> getRecentlyViewed() async {
    final models = await local.getProducts();
    return models.map((e) => e.toEntity()).toList();
  }
  @override
  Future<void> addProduct(ProductEntity product) async {
    final current = await local.getProducts();

    final list = List<Product>.from(current);

    list.removeWhere((p) => p.id == product.id);

    list.insert(
      0,
      Product.fromEntity(product),
    );

    if (list.length > 10) {
      list.removeLast();
    }

    await local.addProducts(list);
  }
  @override
  Future<void> clear() async {
    await local.clear();
  }
}