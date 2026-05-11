import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fork_up/core/providers/app_provider.dart';
import 'package:fork_up/data/recently_viewed/data_source/recently_local_data_source.dart';
import 'package:fork_up/data/recently_viewed/data_source/recently_local_data_source_impl.dart';
import 'package:fork_up/data/recently_viewed/repository/recently_viewed_repo_impl.dart';
import 'package:fork_up/domain/home/entity/product_entity.dart';
import 'package:fork_up/domain/recently_viewed/repository/recently_viewed_repo.dart';
import 'package:fork_up/domain/recently_viewed/use_case/add_product.dart';
import 'package:fork_up/domain/recently_viewed/use_case/clear_recently_product.dart';
import 'package:fork_up/domain/recently_viewed/use_case/get_recently_products.dart';

class RecentlyViewedNotifier extends AsyncNotifier<List<ProductEntity>> {
  @override
  Future<List<ProductEntity>> build() async {
    final useCase = ref.read(getRecentlyViewedUseCaseProvider);
    return await useCase();
  }

  Future<void> add(ProductEntity product) async {
    try {
      final addUseCase = ref.read(addRecentlyViewedUseCaseProvider);

      await addUseCase(product);

      final getUseCase = ref.read(getRecentlyViewedUseCaseProvider);

      final products = await getUseCase();

      state = AsyncData(products);
    } catch (e, stack) {
      state = AsyncError(e, stack);
    }
  }
}

final getRecentlyViewedDataSourceProvider =
    Provider<RecentlyViewedLocalDataSource>((ref) {
      return RecentlyViewedLocalDataSourceImpl(ref.read(sharedPrefsProvider));
    });
final getRecentlyViewedRepoProvider = Provider<RecentlyViewedRepository>((ref) {
  return RecentlyViewedRepositoryImpl(
    ref.read(getRecentlyViewedDataSourceProvider),
  );
});
final addRecentlyViewedUseCaseProvider = Provider<AddRecentlyViewedUseCase>((
  ref,
) {
  return AddRecentlyViewedUseCase(ref.read(getRecentlyViewedRepoProvider));
});
final getRecentlyViewedUseCaseProvider = Provider<GetRecentlyViewedUseCase>((
  ref,
) {
  return GetRecentlyViewedUseCase(ref.read(getRecentlyViewedRepoProvider));
});
final removeRecentlyViewedUseCaseProvider =
    Provider<ClearRecentlyViewedUseCase>((ref) {
      return ClearRecentlyViewedUseCase(
        ref.read(getRecentlyViewedRepoProvider),
      );
    });
