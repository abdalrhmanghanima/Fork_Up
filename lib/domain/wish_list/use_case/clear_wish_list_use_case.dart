import 'package:fork_up/domain/wish_list/repository/wish_list_repo.dart';

class ClearWishListUseCase {
  final WishListRepo repo;

  ClearWishListUseCase(this.repo);

  Future<void> call() async {
    await repo.clear();
  }
}
