import 'package:fork_up/domain/product_details/entity/buy_it_together_entity.dart';
abstract class BuyItTogetherRepo{
  Future<BuyItTogetherEntity> buyItTogether({required String id});
}