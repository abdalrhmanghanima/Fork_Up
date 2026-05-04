import 'package:fork_up/domain/cart/entity/cart_entity.dart';
import 'package:fork_up/domain/cart/repository/cart_repo.dart';
import 'package:injectable/injectable.dart';
@lazySingleton
class GetCartUseCase {
  final CartRepository repo;

  GetCartUseCase(this.repo);

  Future<List<CartEntity>> call() async {
    return await repo.getCart();
  }
}