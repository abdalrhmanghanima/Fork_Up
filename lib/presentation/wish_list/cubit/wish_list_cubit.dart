import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fork_up/presentation/wish_list/cubit/wish_list_state.dart';
import 'package:injectable/injectable.dart';
import 'package:fork_up/domain/home/entity/product_entity.dart';
import 'package:fork_up/domain/wish_list/use_case/get_wish_list_use_case.dart';
import 'package:fork_up/domain/wish_list/use_case/toggle_wish_list_use_case.dart';

@injectable
class WishlistCubit extends Cubit<WishlistState> {
  final GetWishListUseCase getWishListUseCase;
  final ToggleWishListUseCase toggleWishListUseCase;

  WishlistCubit(this.getWishListUseCase, this.toggleWishListUseCase)
    : super(WishlistInitial()) {
    getWishlist();
  }

  Future<void> getWishlist() async {
    try {
      final items = await getWishListUseCase();

      emit(WishlistLoaded(List.from(items)));
    } catch (e) {
      emit(WishlistError(e.toString()));
    }
  }

  Future<void> toggle(ProductEntity product) async {
    if (state is! WishlistLoaded) return;

    final currentItems = List<ProductEntity>.from(
      (state as WishlistLoaded).items,
    );

    final exists = currentItems.any((e) => e.id == product.id);

    if (exists) {
      currentItems.removeWhere((e) => e.id == product.id);
    } else {
      currentItems.add(product);
    }

    emit(WishlistLoaded(currentItems));

    try {
      await toggleWishListUseCase(product);
    } catch (e) {
      throw (e.toString());
    }
  }

  bool isInWishlist(ProductEntity product) {
    if (state is WishlistLoaded) {
      final items = (state as WishlistLoaded).items;
      return items.any((e) => e.id == product.id);
    }
    return false;
  }
}
