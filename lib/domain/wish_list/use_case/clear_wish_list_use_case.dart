import 'package:fork_up/domain/wish_list/repository/wish_list_repo.dart';
import 'package:injectable/injectable.dart';
@lazySingleton
class ClearWishListUseCase {
  final WishListRepo repo;

  ClearWishListUseCase(this.repo);

  Future<void> call() async {
    await repo.clear();
  }
}