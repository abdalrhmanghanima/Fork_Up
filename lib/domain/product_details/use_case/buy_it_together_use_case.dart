import 'package:fork_up/domain/product_details/entity/buy_it_together_entity.dart';
import 'package:fork_up/domain/product_details/repository/buy_it_together_repo.dart';

class BuyItTogetherUseCase {
  BuyItTogetherRepo buyItTogetherRepo;
  BuyItTogetherUseCase(this.buyItTogetherRepo);
  Future<BuyItTogetherEntity> call({required String id}) {
    return buyItTogetherRepo.buyItTogether(id: id);
  }
}
