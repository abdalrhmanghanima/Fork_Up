import 'package:dio/dio.dart';
import 'package:fork_up/core/constants/api_const.dart';
import 'package:fork_up/data/product_details/data_source/buy_it_together_data_source.dart';
import 'package:fork_up/data/product_details/model/buy_it_together_model.dart';

class BuyItTogetherRemoteDataSourceImpl extends BuyItTogetherRemoteDataSource{
  final Dio dio;
  BuyItTogetherRemoteDataSourceImpl(this.dio);
  @override
  Future<BuyItTogetherModel> buyItTogether({required String id}) async{
    final response = await dio.get('${ApiConstants.buyItTogether}$id',
      options: Options(
        headers: {
          "Accept": "application/json",
        }
      ),
    );
    return BuyItTogetherModel.fromJson(response.data);
  }
}