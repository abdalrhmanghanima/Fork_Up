import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fork_up/core/providers/app_provider.dart';
import 'package:fork_up/data/product_details/data_source/buy_it_together_data_source.dart';
import 'package:fork_up/data/product_details/data_source/buy_it_together_data_source_impl.dart';
import 'package:fork_up/data/product_details/repository/buy_it_togethe_repo_impl.dart';
import 'package:fork_up/domain/product_details/entity/buy_it_together_entity.dart';
import 'package:fork_up/domain/product_details/repository/buy_it_together_repo.dart';
import 'package:fork_up/domain/product_details/use_case/buy_it_together_use_case.dart';

class BuyItTogetherNotifier extends FamilyAsyncNotifier<BuyItTogetherEntity,String>{
  @override
  Future<BuyItTogetherEntity> build( String id) {

    final useCase = ref.read(buyTogetherUseCaseProvider);
    return useCase(id: id);
  }
}
final buyTogetherRemoteSourceProvider = Provider<BuyItTogetherRemoteDataSource>((ref){
  return BuyItTogetherRemoteDataSourceImpl(ref.read(dioProvider));
});
final buyTogetherRepoProvider = Provider<BuyItTogetherRepo>((ref){
  return BuyItTogetherRepoImpl(ref.read(buyTogetherRemoteSourceProvider));
});
final buyTogetherUseCaseProvider = Provider<BuyItTogetherUseCase>((ref){
  return BuyItTogetherUseCase(ref.read(buyTogetherRepoProvider));
});