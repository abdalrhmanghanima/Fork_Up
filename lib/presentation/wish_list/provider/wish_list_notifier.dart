import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fork_up/domain/home/entity/product_entity.dart';

class WishlistNotifier
    extends Notifier<List<ProductEntity>> {

  @override
  List<ProductEntity> build() {

    return [];
  }

  void toggle(
      ProductEntity product,
      ) {

    final current =
    List<ProductEntity>.from(state);

    final exists = current.any(
          (e) => e.id == product.id,
    );

    if (exists) {

      current.removeWhere(
            (e) => e.id == product.id,
      );

    } else {

      current.add(product);
    }

    state = current;
  }

  bool isInWishlist(
      ProductEntity product,
      ) {

    return state.any(
          (e) => e.id == product.id,
    );
  }
}