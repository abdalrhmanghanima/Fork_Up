import 'package:fork_up/domain/cart/repository/cart_repo.dart';

class DecreaseQuantityUseCase {
  final CartRepository repo;

  DecreaseQuantityUseCase(this.repo);

  Future<void> call(int productId) async {
    await repo.decreaseQuantity(productId);
  }
}