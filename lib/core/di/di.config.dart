// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:fork_up/core/di/di.dart' as _i986;
import 'package:fork_up/data/cart/repository/cart_repo_impl.dart' as _i850;
import 'package:fork_up/data/home/data_source/home_remote_data_source.dart'
    as _i117;
import 'package:fork_up/data/home/data_source/home_remote_data_source_impl.dart'
    as _i725;
import 'package:fork_up/data/home/repository/home_repo_impl.dart' as _i689;
import 'package:fork_up/data/product_details/data_source/product_details_remote_data_source.dart'
    as _i911;
import 'package:fork_up/data/product_details/data_source/product_details_remote_data_source_impl.dart'
    as _i448;
import 'package:fork_up/data/product_details/repository/product_repo_impl.dart'
    as _i809;
import 'package:fork_up/data/recently_viewed/data_source/recently_local_data_source.dart'
    as _i933;
import 'package:fork_up/data/recently_viewed/data_source/recently_local_data_source_impl.dart'
    as _i355;
import 'package:fork_up/data/recently_viewed/repository/recently_viewed_repo_impl.dart'
    as _i100;
import 'package:fork_up/data/whole_sale/data_source/get_products_remote_data_source.dart'
    as _i136;
import 'package:fork_up/data/whole_sale/data_source/get_products_remote_data_source_impl.dart'
    as _i976;
import 'package:fork_up/data/whole_sale/repository/get_products_repo_impl.dart'
    as _i231;
import 'package:fork_up/data/wish_list/repository/wish_list_repo_impl.dart'
    as _i929;
import 'package:fork_up/domain/cart/repository/cart_repo.dart' as _i978;
import 'package:fork_up/domain/cart/use_case/add_to_cart_use_case.dart'
    as _i716;
import 'package:fork_up/domain/cart/use_case/clear_cart_use_case.dart' as _i758;
import 'package:fork_up/domain/cart/use_case/get_cart_use_case.dart' as _i490;
import 'package:fork_up/domain/cart/use_case/remove_from_cart_use_case.dart'
    as _i620;
import 'package:fork_up/domain/cart/use_case/search_use_case.dart' as _i255;
import 'package:fork_up/domain/home/repository/home_repo.dart' as _i1007;
import 'package:fork_up/domain/home/use_case/home_use_case.dart' as _i567;
import 'package:fork_up/domain/product_details/repository/product_repo.dart'
    as _i381;
import 'package:fork_up/domain/product_details/use_case/product_use_case.dart'
    as _i441;
import 'package:fork_up/domain/recently_viewed/repository/recently_viewed_repo.dart'
    as _i169;
import 'package:fork_up/domain/recently_viewed/use_case/add_product.dart'
    as _i676;
import 'package:fork_up/domain/recently_viewed/use_case/clear_recently_product.dart'
    as _i251;
import 'package:fork_up/domain/recently_viewed/use_case/get_recently_products.dart'
    as _i987;
import 'package:fork_up/domain/whole_sale/repository/get_products_repo.dart'
    as _i147;
import 'package:fork_up/domain/whole_sale/use_case/get_products_use_case.dart'
    as _i64;
import 'package:fork_up/domain/wish_list/repository/wish_list_repo.dart'
    as _i970;
import 'package:fork_up/domain/wish_list/use_case/clear_wish_list_use_case.dart'
    as _i195;
import 'package:fork_up/domain/wish_list/use_case/get_wish_list_use_case.dart'
    as _i708;
import 'package:fork_up/domain/wish_list/use_case/toggle_wish_list_use_case.dart'
    as _i403;
import 'package:fork_up/presentation/cart/cubit/cart_cubit.dart' as _i628;
import 'package:fork_up/presentation/cart/cubit/search_cubit.dart' as _i1043;
import 'package:fork_up/presentation/home/cubit/home_cubit.dart' as _i700;
import 'package:fork_up/presentation/menu/cubit/navigation_cubit.dart' as _i179;
import 'package:fork_up/presentation/product_details/cubit/product_cubit.dart'
    as _i535;
import 'package:fork_up/presentation/shared/cubit/recently_viewed_cubit.dart'
    as _i674;
import 'package:fork_up/presentation/whole_sale/cubit/whole_sale_cubit.dart'
    as _i666;
import 'package:fork_up/presentation/wish_list/cubit/wish_list_cubit.dart'
    as _i268;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final registerModule = _$RegisterModule();
    await gh.factoryAsync<_i460.SharedPreferences>(
      () => registerModule.prefs(),
      preResolve: true,
    );
    gh.factory<_i179.NavigationCubit>(() => _i179.NavigationCubit());
    gh.lazySingleton<_i361.Dio>(() => registerModule.dio());
    gh.lazySingleton<_i911.ProductDetailsRemoteDataSource>(
      () => _i448.ProductDetailsRemoteDataSourceImpl(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i117.HomeRemoteDataSource>(
      () => _i725.HomeRemoteDataSourceImpl(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i978.CartRepository>(() => _i850.CartRepositoryImpl());
    gh.lazySingleton<_i970.WishListRepo>(() => _i929.WishListRepositoryImpl());
    gh.lazySingleton<_i136.GetProductsRemoteDataSource>(
      () => _i976.GetProductsRemoteDataSourceImpl(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i1007.HomeRepo>(
      () => _i689.HomeRepositoryImpl(gh<_i117.HomeRemoteDataSource>()),
    );
    gh.lazySingleton<_i381.ProductRepo>(
      () => _i809.ProductRepoImpl(gh<_i911.ProductDetailsRemoteDataSource>()),
    );
    gh.lazySingleton<_i933.RecentlyViewedLocalDataSource>(
      () => _i355.RecentlyViewedLocalDataSourceImpl(
        gh<_i460.SharedPreferences>(),
      ),
    );
    gh.lazySingleton<_i441.GetProductDetailsUseCase>(
      () => _i441.GetProductDetailsUseCase(gh<_i381.ProductRepo>()),
    );
    gh.lazySingleton<_i567.GetHomeDataUseCase>(
      () => _i567.GetHomeDataUseCase(gh<_i1007.HomeRepo>()),
    );
    gh.factory<_i535.ProductDetailsCubit>(
      () => _i535.ProductDetailsCubit(gh<_i441.GetProductDetailsUseCase>()),
    );
    gh.lazySingleton<_i147.GetProductsRepo>(
      () => _i231.GetProductsRepoImpl(gh<_i136.GetProductsRemoteDataSource>()),
    );
    gh.lazySingleton<_i255.SearchUseCase>(
      () => _i255.SearchUseCase(gh<_i147.GetProductsRepo>()),
    );
    gh.lazySingleton<_i195.ClearWishListUseCase>(
      () => _i195.ClearWishListUseCase(gh<_i970.WishListRepo>()),
    );
    gh.lazySingleton<_i708.GetWishListUseCase>(
      () => _i708.GetWishListUseCase(gh<_i970.WishListRepo>()),
    );
    gh.lazySingleton<_i403.ToggleWishListUseCase>(
      () => _i403.ToggleWishListUseCase(gh<_i970.WishListRepo>()),
    );
    gh.lazySingleton<_i716.AddToCartUseCase>(
      () => _i716.AddToCartUseCase(gh<_i978.CartRepository>()),
    );
    gh.lazySingleton<_i758.ClearCartUseCase>(
      () => _i758.ClearCartUseCase(gh<_i978.CartRepository>()),
    );
    gh.lazySingleton<_i490.GetCartUseCase>(
      () => _i490.GetCartUseCase(gh<_i978.CartRepository>()),
    );
    gh.lazySingleton<_i620.RemoveFromCartUseCase>(
      () => _i620.RemoveFromCartUseCase(gh<_i978.CartRepository>()),
    );
    gh.lazySingleton<_i169.RecentlyViewedRepository>(
      () => _i100.RecentlyViewedRepositoryImpl(
        gh<_i933.RecentlyViewedLocalDataSource>(),
      ),
    );
    gh.lazySingleton<_i64.GetProductsUseCase>(
      () => _i64.GetProductsUseCase(gh<_i147.GetProductsRepo>()),
    );
    gh.factory<_i268.WishlistCubit>(
      () => _i268.WishlistCubit(
        gh<_i708.GetWishListUseCase>(),
        gh<_i403.ToggleWishListUseCase>(),
      ),
    );
    gh.factory<_i700.HomeCubit>(
      () => _i700.HomeCubit(gh<_i567.GetHomeDataUseCase>()),
    );
    gh.factory<_i628.CartCubit>(
      () => _i628.CartCubit(
        gh<_i716.AddToCartUseCase>(),
        gh<_i490.GetCartUseCase>(),
        gh<_i758.ClearCartUseCase>(),
        gh<_i620.RemoveFromCartUseCase>(),
      ),
    );
    gh.factory<_i1043.SearchCubit>(
      () => _i1043.SearchCubit(gh<_i255.SearchUseCase>()),
    );
    gh.factory<_i666.WholeSaleCubit>(
      () => _i666.WholeSaleCubit(gh<_i64.GetProductsUseCase>()),
    );
    gh.lazySingleton<_i676.AddRecentlyViewedUseCase>(
      () =>
          _i676.AddRecentlyViewedUseCase(gh<_i169.RecentlyViewedRepository>()),
    );
    gh.lazySingleton<_i251.ClearRecentlyViewedUseCase>(
      () => _i251.ClearRecentlyViewedUseCase(
        gh<_i169.RecentlyViewedRepository>(),
      ),
    );
    gh.lazySingleton<_i987.GetRecentlyViewedUseCase>(
      () =>
          _i987.GetRecentlyViewedUseCase(gh<_i169.RecentlyViewedRepository>()),
    );
    gh.factory<_i674.RecentlyViewedCubit>(
      () => _i674.RecentlyViewedCubit(
        gh<_i987.GetRecentlyViewedUseCase>(),
        gh<_i676.AddRecentlyViewedUseCase>(),
      ),
    );
    return this;
  }
}

class _$RegisterModule extends _i986.RegisterModule {}
