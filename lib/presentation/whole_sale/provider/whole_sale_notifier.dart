import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fork_up/core/providers/app_provider.dart';
import 'package:fork_up/data/whole_sale/data_source/get_products_remote_data_source.dart';
import 'package:fork_up/data/whole_sale/data_source/get_products_remote_data_source_impl.dart';
import 'package:fork_up/data/whole_sale/repository/get_products_repo_impl.dart';
import 'package:fork_up/domain/home/entity/product_entity.dart';
import 'package:fork_up/domain/whole_sale/repository/get_products_repo.dart';
import 'package:fork_up/domain/whole_sale/use_case/get_products_use_case.dart';

class WholeSaleNotifier extends AsyncNotifier<List<ProductEntity>> {

  int currentPage = 1;

  bool isLoadingMore = false;

  bool hasMore = true;

  List<ProductEntity> allProducts = [];

  int? currentCategoryId;

  int? currentSubCategoryId;

  @override
  Future<List<ProductEntity>> build() async {
    return [];
  }

  Future<void> getProducts({
    int? categoryId,
    int? subCategoryId,
  }) async {

    state = const AsyncLoading();

    try {

      currentCategoryId = categoryId;

      currentSubCategoryId = subCategoryId;

      final useCase = ref.read(getProductsUseCaseProvider);

      final products = await useCase(
        page: 1,
        categoryId: categoryId,
        subCategoryId: subCategoryId,
      );

      currentPage = 1;

      allProducts = products;

      hasMore = products.length == 15;

      state = AsyncData(
        List.from(allProducts),
      );

    } catch (e, stack) {

      state = AsyncError(e, stack);
    }
  }

  Future<void> loadMore() async {

    if (isLoadingMore || !hasMore) {
      return;
    }

    isLoadingMore = true;

    currentPage++;

    try {

      final useCase =
      ref.read(getProductsUseCaseProvider);

      final products = await useCase(
        page: currentPage,
        categoryId: currentCategoryId,
        subCategoryId: currentSubCategoryId,
      );

      if (products.isEmpty) {

        hasMore = false;

      } else {

        allProducts.addAll(products);
      }

      state = AsyncData(
        List.from(allProducts),
      );

    } catch (e, stack) {

      state = AsyncError(e, stack);
    }

    isLoadingMore = false;
  }
}

final getProductsDataSourceProvider =
Provider<GetProductsRemoteDataSource>((ref) {

  return GetProductsRemoteDataSourceImpl(
    ref.read(dioProvider),
  );
});

final getProductsRepoProvider =
Provider<GetProductsRepo>((ref) {

  return GetProductsRepoImpl(
    ref.read(getProductsDataSourceProvider),
  );
});

final getProductsUseCaseProvider =
Provider<GetProductsUseCase>((ref) {

  return GetProductsUseCase(
    ref.read(getProductsRepoProvider),
  );
});