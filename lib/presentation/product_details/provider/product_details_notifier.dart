import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fork_up/core/providers/app_provider.dart';
import 'package:fork_up/data/product_details/data_source/product_details_remote_data_source.dart';
import 'package:fork_up/data/product_details/data_source/product_details_remote_data_source_impl.dart';
import 'package:fork_up/data/product_details/repository/product_repo_impl.dart';
import 'package:fork_up/domain/product_details/entity/product_details_entity.dart';
import 'package:fork_up/domain/product_details/repository/product_repo.dart';
import 'package:fork_up/domain/product_details/use_case/product_use_case.dart';

class ProductDetailsNotifier extends FamilyAsyncNotifier<ProductDetailsEntity,String>{
  @override
  Future<ProductDetailsEntity> build(String slug) {
    final useCase =  ref.read(getProductDetailsUseCaseProvider);

    return useCase(slug);
  }
}

final getProductDetailsDataSourceProvider = Provider<ProductDetailsRemoteDataSource>((ref){
  return ProductDetailsRemoteDataSourceImpl(ref.read(dioProvider));
});
final getProductDetailsRepoProvider = Provider<ProductRepo>((ref){
  return ProductRepoImpl(ref.read(getProductDetailsDataSourceProvider));
});
final getProductDetailsUseCaseProvider = Provider<GetProductDetailsUseCase>((ref){
  return GetProductDetailsUseCase(ref.read(getProductDetailsRepoProvider));
});