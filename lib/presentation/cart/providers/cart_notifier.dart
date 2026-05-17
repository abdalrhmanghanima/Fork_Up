import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fork_up/core/providers/app_provider.dart';
import 'package:fork_up/data/cart/data_source/cart_local_data_source.dart';
import 'package:fork_up/data/cart/data_source/cart_local_data_source_impl.dart';
import 'package:fork_up/data/cart/data_source/cart_remote_data_source.dart';
import 'package:fork_up/data/cart/data_source/cart_remote_data_source_impl.dart';
import 'package:fork_up/data/cart/model/cart_model.dart';
import 'package:fork_up/data/cart/repository/cart_repo_impl.dart';
import 'package:fork_up/domain/cart/entity/cart_entity.dart';
import 'package:fork_up/domain/cart/repository/cart_repo.dart';
import 'package:fork_up/domain/cart/use_case/add_to_cart_use_case.dart';
import 'package:fork_up/domain/cart/use_case/decrease_quantity_use_case.dart';
import 'package:fork_up/domain/cart/use_case/get_cart_use_case.dart';
import 'package:fork_up/domain/cart/use_case/get_remote_cart_use_case.dart';
import 'package:fork_up/domain/cart/use_case/remove_from_cart_use_case.dart';
import 'package:fork_up/domain/home/entity/product_entity.dart';
import 'package:hive/hive.dart';

class CartNotifier extends AsyncNotifier<List<CartEntity>> {
  @override
  Future<List<CartEntity>> build() async{

    final localCart = await getCart();

    syncCart();

    return localCart;
  }

  Future<List<CartEntity>> getCart() async {
    final useCase = ref.read(getCartUseCaseProvider);
    return await useCase();
  }

  Future<void> addToCart(ProductEntity product, {int quantity = 1}) async {
    try {
      final useCase = ref.read(addToCartUseCaseProvider);
      await useCase(product, quantity: quantity);
      await refreshCart();
    } catch (e, stack) {
      state = AsyncError(e, stack);
    }
  }

  Future<void> remove(int productId) async {
    try {
      final useCase = ref.read(removeFromCartUseCaseProvider);

      await useCase(productId);

      await refreshCart();
    } catch (e, stack) {
      state = AsyncError(e, stack);
    }
  }

  Future<void> increaseQuantity(ProductEntity product) async {
    await addToCart(product);
  }

  Future<void> decreaseQuantity(ProductEntity product) async {
    try {
      final useCase = ref.read(
        decreaseQuantityUseCaseProvider,
      );

      await useCase(product.id);

      await refreshCart();
    } catch (e, stack) {
      state = AsyncError(e, stack);
    }
  }
  bool isInCart(ProductEntity product) {
    final items = state.value ?? [];

    return items.any((e) => e.product.id == product.id);
  }
  Future<void> refreshCart() async {
    final items = await ref.read(getCartUseCaseProvider)();
    state = AsyncData(items);
  }
  bool _isSyncing = false;

  Future<void> syncCart() async {
    print('SYNC STARTED');


    if (_isSyncing) return;

    _isSyncing = true;

    try {

      final remoteItems =
      await ref.read(
        getRemoteCartUseCaseProvider,
      )();

      final local =
      ref.read(cartLocalDataSourceProvider);

      await local.clearCart();

      for (final item in remoteItems) {

        await local.addToCart(
          CartModel.fromEntity(item),
        );
      }

      await refreshCart();
      print('UI REFRESHED');

    } catch (e) {

      print(e);

    } finally {

      _isSyncing = false;
    }
  }
}
final cartLocalDataSourceProvider = Provider<CartLocalDataSource>((ref){
  return CartLocalDataSourceImpl(Hive.box<CartModel>('cartBox'));
});
final cartRemoteDataSourceProvider =
Provider<CartRemoteDataSource>((ref) {
  return CartRemoteDataSourceImpl(ref.read(dioProvider));
});
final cartRepoProvider = Provider<CartRepository>((ref) {
  return CartRepositoryImpl(
      ref.read(cartLocalDataSourceProvider),
      ref.read(cartRemoteDataSourceProvider),
      );
});

final getCartUseCaseProvider = Provider<GetCartUseCase>((ref) {
  return GetCartUseCase(ref.read(cartRepoProvider));
});

final addToCartUseCaseProvider = Provider<AddToCartUseCase>((ref) {
  return AddToCartUseCase(ref.read(cartRepoProvider));
});

final removeFromCartUseCaseProvider = Provider<RemoveFromCartUseCase>((ref) {
  return RemoveFromCartUseCase(ref.read(cartRepoProvider));
});

final decreaseQuantityUseCaseProvider =
Provider<DecreaseQuantityUseCase>((ref) {
  return DecreaseQuantityUseCase(
    ref.read(cartRepoProvider),
  );
});
final getRemoteCartUseCaseProvider =
Provider<GetRemoteCartUseCase>((ref) {
  return GetRemoteCartUseCase(
    ref.read(cartRepoProvider),
  );
});