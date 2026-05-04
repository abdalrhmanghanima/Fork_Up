import 'package:fork_up/domain/home/entity/product_entity.dart';

abstract class WholeSaleState {}

class WholeSaleInitial extends WholeSaleState {}

class WholeSaleLoading extends WholeSaleState {}

class WholeSaleSuccess extends WholeSaleState {
  final List<ProductEntity> products;

  WholeSaleSuccess(this.products);
}

class WholeSaleError extends WholeSaleState {
  final String message;

  WholeSaleError(this.message);
}