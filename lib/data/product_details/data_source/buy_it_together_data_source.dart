import 'package:fork_up/data/product_details/model/buy_it_together_model.dart';

abstract class BuyItTogetherRemoteDataSource{
  Future<BuyItTogetherModel> buyItTogether({required String id});
}