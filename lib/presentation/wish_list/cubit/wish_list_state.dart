import 'package:fork_up/domain/home/entity/product_entity.dart';

abstract class WishlistState {}

class WishlistInitial extends WishlistState {}

class WishlistLoading extends WishlistState {}

class WishlistLoaded extends WishlistState {
  final List<ProductEntity> items;

  WishlistLoaded(this.items);
}

class WishlistError extends WishlistState {
  final String message;

  WishlistError(this.message);
}