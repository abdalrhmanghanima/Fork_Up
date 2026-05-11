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
          "Authorization":
              "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczovL21heGltLmVudmlyb2dyb3VwLmlvL2FwaS92NS91c2VyL2F1dGgvbG9naW4iLCJpYXQiOjE3NzYxOTk1MzgsImV4cCI6MTc3ODc5MTUzOCwibmJmIjoxNzc2MTk5NTM4LCJqdGkiOiJ1eXF4VVczN2VlUWZvVlRTIiwic3ViIjoiNjYiLCJwcnYiOiIyM2JkNWM4OTQ5ZjYwMGFkYjM5ZTcwMWM0MDA4NzJkYjdhNTk3NmY3In0.Jm25W7q2ps4rtRzsJUcpB95Q2K3dqQ7AcAUqkIptOOI",
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
