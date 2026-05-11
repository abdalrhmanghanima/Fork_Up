import 'package:fork_up/data/whole_sale/data_source/get_products_remote_data_source.dart';
import 'package:fork_up/domain/home/entity/product_entity.dart';
import 'package:fork_up/domain/whole_sale/repository/get_products_repo.dart';

class GetProductsRepoImpl implements GetProductsRepo{
  final GetProductsRemoteDataSource remoteDataSource;
  GetProductsRepoImpl(this.remoteDataSource);
  @override
  Future<List<ProductEntity>> getProducts({
    required int page,
    int? categoryId,
    int? subCategoryId,}) async {
    final models = await remoteDataSource.getProducts(
      page: page,
      categoryId: categoryId,
      subCategoryId: subCategoryId,);
    return models.map((e) => e.toEntity()).toList();
  }
}