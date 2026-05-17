import 'package:fork_up/data/product_details/data_source/buy_it_together_data_source.dart';
import 'package:fork_up/domain/product_details/entity/buy_it_together_entity.dart';
import 'package:fork_up/domain/product_details/repository/buy_it_together_repo.dart';

class BuyItTogetherRepoImpl implements BuyItTogetherRepo {
  BuyItTogetherRemoteDataSource buyItTogetherRemoteDataSource;
  BuyItTogetherRepoImpl(this.buyItTogetherRemoteDataSource);
  @override
  Future<BuyItTogetherEntity> buyItTogether({required String id}) {
    return buyItTogetherRemoteDataSource.buyItTogether(id: id);
  }
}
