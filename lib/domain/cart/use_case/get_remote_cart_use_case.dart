import 'package:fork_up/domain/cart/entity/cart_entity.dart';
import 'package:fork_up/domain/cart/repository/cart_repo.dart';

class GetRemoteCartUseCase {

  final CartRepository repo;

  GetRemoteCartUseCase(this.repo);

  Future<List<CartEntity>> call() async {
    return await repo.getRemoteCart();
  }
}