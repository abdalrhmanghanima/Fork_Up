

import 'package:fork_up/domain/home/entity/product_entity.dart';

class RecentlyViewedState {
  final List<ProductEntity> products;

  RecentlyViewedState({
    required this.products,
  });

  RecentlyViewedState copyWith({
    List<ProductEntity>? products,
  }) {
    return RecentlyViewedState(
      products: products ?? this.products,
    );
  }
}