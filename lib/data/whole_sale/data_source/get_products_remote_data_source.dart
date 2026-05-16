import 'package:fork_up/data/home/model/product_model.dart';

abstract class GetProductsRemoteDataSource {
  Future<List<Product>> getProducts({
    required int page,
    int? categoryId,
    int? subCategoryId,
  });
}
