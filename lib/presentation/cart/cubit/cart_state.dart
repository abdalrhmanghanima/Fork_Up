import 'package:fork_up/domain/cart/entity/cart_entity.dart';

abstract class CartState {}

class CartInitial extends CartState {}

class CartLoading extends CartState {}

class CartLoaded extends CartState {
  final List<CartEntity> items;

  CartLoaded(this.items);
}

class CartError extends CartState {
  final String message;

  CartError(this.message);
}