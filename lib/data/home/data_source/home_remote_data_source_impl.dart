import 'package:dio/dio.dart';
import 'package:fork_up/core/constants/api_const.dart';
import 'package:fork_up/data/home/data_source/home_remote_data_source.dart';
import 'package:fork_up/data/home/model/home_model.dart';
class HomeRemoteDataSourceImpl extends HomeRemoteDataSource{
  final Dio dio;
  HomeRemoteDataSourceImpl(this.dio);
  @override
  Future<HomeResponse> getHomeData() async{
    final response = await dio.get(ApiConstants.getHomeData);
    return HomeResponse.fromJson(response.data);
  }
}