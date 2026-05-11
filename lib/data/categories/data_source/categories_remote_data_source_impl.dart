import 'package:dio/dio.dart';
import 'package:fork_up/core/constants/api_const.dart';
import 'package:fork_up/data/categories/data_source/categories_remote_data_source.dart';
import 'package:fork_up/data/categories/model/categories_response_model.dart';

class CategoriesRemoteDataSourceImpl extends CategoriesRemoteDataSource {
  final Dio dio;
  CategoriesRemoteDataSourceImpl(this.dio);
  @override
  Future<CategoriesResponseModel> getCategories() async {
    final response = await dio.get(ApiConstants.getCategories);
    return CategoriesResponseModel.fromJson(response.data);
  }
}
