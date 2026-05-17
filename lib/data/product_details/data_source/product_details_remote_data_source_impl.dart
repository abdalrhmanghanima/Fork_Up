import 'package:dio/dio.dart';
import 'package:fork_up/core/constants/api_const.dart';
import 'package:fork_up/data/product_details/data_source/product_details_remote_data_source.dart';
import 'package:fork_up/data/product_details/model/product_model.dart';

class ProductDetailsRemoteDataSourceImpl
    extends ProductDetailsRemoteDataSource {
  final Dio dio;

  ProductDetailsRemoteDataSourceImpl(this.dio);

  @override
  Future<ProductDetailsModel> getProductDetails(String slug) async {
    final response = await dio.get(
      ApiConstants.getProductDetails,
      queryParameters: {"slug": slug},
      options: Options(
        headers: {
          "Accept": "application/json",
          "Accept-Language": "en",
        },
      ),
    );

    final data = response.data;

    if (data == null || data['data'] == null) {
      throw Exception(data['msg'] ?? "Unknown error");
    }

    final productJson = data['data']['productDetails'];

    return ProductDetailsModel.fromJson(productJson);
  }
}
