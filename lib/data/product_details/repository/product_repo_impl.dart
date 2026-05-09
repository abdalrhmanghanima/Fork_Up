import 'package:fork_up/data/product_details/data_source/product_details_remote_data_source.dart';
import 'package:fork_up/domain/product_details/entity/product_details_entity.dart';
import 'package:fork_up/domain/product_details/repository/product_repo.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: ProductRepo)
class ProductRepoImpl implements ProductRepo {
  final ProductDetailsRemoteDataSource remote;

  ProductRepoImpl(this.remote);

  @override
  Future<ProductDetailsEntity> getProductDetails(String slug) async {
    final result = await remote.getProductDetails(slug);

    return result.toEntity();
  }
}
