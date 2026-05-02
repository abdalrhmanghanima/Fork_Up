import 'package:fork_up/domain/product_details/entity/product_details_entity.dart';
abstract class ProductState {}

class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {}

class ProductSuccess extends ProductState {
  final ProductDetailsEntity product;

  ProductSuccess(this.product);
}

class ProductError extends ProductState {
  final String message;

  ProductError(this.message);
}