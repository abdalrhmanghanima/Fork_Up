import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fork_up/data/cart/repository/cart_repo_impl.dart';
import 'package:fork_up/domain/cart/entity/cart_entity.dart';
import 'package:fork_up/domain/cart/repository/cart_repo.dart';
import 'package:fork_up/domain/cart/use_case/add_to_cart_use_case.dart';
import 'package:fork_up/domain/cart/use_case/get_cart_use_case.dart';
import 'package:fork_up/domain/cart/use_case/remove_from_cart_use_case.dart';
import 'package:fork_up/domain/home/entity/product_entity.dart';

class CartNotifier extends AsyncNotifier<List<CartEntity>> {
  @override
  Future<List<CartEntity>> build() {
    return getCart();
  }

  Future<List<CartEntity>> getCart() async {
    final useCase = ref.read(getCartUseCaseProvider);
    return await useCase();
  }

  Future<void> addToCart(ProductEntity product, {int quantity = 1}) async {
    try {
      final useCase = ref.read(addToCartUseCaseProvider);
      await useCase(product, quantity: quantity);
      state = const AsyncLoading();

      final getCartUseCase = ref.read(getCartUseCaseProvider);

      final items = await getCartUseCase();

      state = AsyncData(items);
    } catch (e, stack) {
      state = AsyncError(e, stack);
    }
  }

  Future<void> remove(ProductEntity product) async {
    try {
      final useCase = ref.read(removeFromCartUseCaseProvider);

      await useCase(product);

      final current = state.value ?? [];

      final updated = current.where((e) => e.product.id != product.id).toList();

      state = AsyncData(updated);
    } catch (e, stack) {
      state = AsyncError(e, stack);
    }
  }

  Future<void> increaseQuantity(ProductEntity product) async {
    final current = state.value ?? [];

    final updated = current.map((e) {
      if (e.product.id == product.id) {
        return e.copyWith(quantity: e.quantity + 1);
      }

      return e;
    }).toList();

    state = AsyncData(updated);
  }

  Future<void> decreaseQuantity(ProductEntity product) async {
    final current = state.value ?? [];

    final updated = current.map((e) {
      if (e.product.id == product.id && e.quantity > 1) {
        return e.copyWith(quantity: e.quantity - 1);
      }

      return e;
    }).toList();

    state = AsyncData(updated);
  }

  bool isInCart(ProductEntity product) {
    final items = state.value ?? [];

    return items.any((e) => e.product.id == product.id);
  }
}

final cartRepoProvider = Provider<CartRepository>((ref) {
  return CartRepositoryImpl();
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
