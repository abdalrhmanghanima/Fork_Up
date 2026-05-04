import 'package:fork_up/domain/cart/repository/cart_repo.dart';
import 'package:fork_up/domain/home/entity/product_entity.dart';
import 'package:injectable/injectable.dart';
@lazySingleton
class RemoveFromCartUseCase {
  final CartRepository repo;

  RemoveFromCartUseCase(this.repo);

  Future<void> call(ProductEntity product) async {
    await repo.removeFromCart(product);
  }
}