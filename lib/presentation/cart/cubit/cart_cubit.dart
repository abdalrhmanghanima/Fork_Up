import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fork_up/domain/cart/use_case/add_to_cart_use_case.dart';
import 'package:fork_up/domain/cart/use_case/clear_cart_use_case.dart';
import 'package:fork_up/domain/cart/use_case/get_cart_use_case.dart';
import 'package:fork_up/domain/cart/use_case/remove_from_cart_use_case.dart';
import 'package:fork_up/domain/home/entity/product_entity.dart';
import 'package:fork_up/presentation/cart/cubit/cart_state.dart';
import 'package:injectable/injectable.dart';

@injectable
class CartCubit extends Cubit<CartState> {
  final AddToCartUseCase addToCartUseCase;
  final GetCartUseCase getCartUseCase;
  final ClearCartUseCase clearCartUseCase;
  final RemoveFromCartUseCase removeFromCartUseCase;

  CartCubit(
    this.addToCartUseCase,
    this.getCartUseCase,
    this.clearCartUseCase,
    this.removeFromCartUseCase,
  ) : super(CartInitial());

  Future<void> getCart() async {
    try {
      emit(CartLoading());

      final items = await getCartUseCase();

      emit(CartLoaded(items));
    } catch (e) {
      emit(CartError(e.toString()));
    }
  }

  Future<void> addToCart(ProductEntity product, {int quantity = 1}) async {
    try {
      await addToCartUseCase(product, quantity: quantity);
      await getCart();
    } catch (e) {
      emit(CartError(e.toString()));
    }
  }

  Future<void> remove(ProductEntity product) async {
    try {
      await removeFromCartUseCase(product);

      if (state is CartLoaded) {
        final current = (state as CartLoaded).items;

        final updated = current
            .where((e) => e.product.id != product.id)
            .toList();

        emit(CartLoaded(updated));
      }
    } catch (e) {
      emit(CartError(e.toString()));
    }
  }

  Future<void> clearCart() async {
    try {
      await clearCartUseCase();
      emit(CartLoaded([]));
    } catch (e) {
      emit(CartError(e.toString()));
    }
  }
  Future<void> increaseQuantity(ProductEntity product) async {
    if (state is CartLoaded) {
      final current = (state as CartLoaded).items;

      final updated = current.map((e) {
        if (e.product.id == product.id) {
          return e.copyWith(quantity: e.quantity + 1);
        }
        return e;
      }).toList();

      emit(CartLoaded(updated));
    }
  }
  Future<void> decreaseQuantity(ProductEntity product) async {
    if (state is CartLoaded) {
      final current = (state as CartLoaded).items;

      final updated = current.map((e) {
        if (e.product.id == product.id && e.quantity > 1) {
          return e.copyWith(quantity: e.quantity - 1);
        }
        return e;
      }).toList();

      emit(CartLoaded(updated));
    }
  }
}
