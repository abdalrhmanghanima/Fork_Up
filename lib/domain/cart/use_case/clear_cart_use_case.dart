import 'package:fork_up/domain/cart/repository/cart_repo.dart';
import 'package:injectable/injectable.dart';
@lazySingleton
class ClearCartUseCase {
  final CartRepository repo;

  ClearCartUseCase(this.repo);

  Future<void> call() async {
    await repo.clear();
  }
}