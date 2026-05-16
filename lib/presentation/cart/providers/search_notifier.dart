import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fork_up/core/providers/app_provider.dart';
import 'package:fork_up/data/whole_sale/data_source/get_products_remote_data_source.dart';
import 'package:fork_up/data/whole_sale/data_source/get_products_remote_data_source_impl.dart';
import 'package:fork_up/data/whole_sale/repository/get_products_repo_impl.dart';
import 'package:fork_up/domain/cart/use_case/search_use_case.dart';
import 'package:fork_up/domain/home/entity/product_entity.dart';
import 'package:fork_up/domain/whole_sale/repository/get_products_repo.dart';

class SearchNotifier extends AsyncNotifier<List<ProductEntity>> {
  List<ProductEntity> allProducts = [];
  @override
  Future<List<ProductEntity>> build() async {
    final useCase = ref.read(searchUseCaseProvider);
    allProducts = await useCase.getAllProducts();
    return [];
  }

  Future<void> search(String query) async {
    if (query.isEmpty) {
      state = const AsyncData([]);
      return;
    }
    state = const AsyncLoading();
    try {
      final result = allProducts.where((product) {
        return product.name.toLowerCase().contains(query.toLowerCase());
      }).toList();
      state = AsyncData(result);
    } catch (e, stack) {
      state = AsyncError(e, stack);
    }
  }
}

final getProductsDataSourceProvider = Provider<GetProductsRemoteDataSource>((
  ref,
) {
  return GetProductsRemoteDataSourceImpl(ref.read(dioProvider));
});
final getProductsRepoProvider = Provider<GetProductsRepo>((ref) {
  return GetProductsRepoImpl(ref.read(getProductsDataSourceProvider));
});
final searchUseCaseProvider = Provider<SearchUseCase>((ref) {
  return SearchUseCase(ref.read(getProductsRepoProvider));
});
