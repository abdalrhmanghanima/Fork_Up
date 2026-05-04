import 'package:dio/dio.dart';
import 'package:fork_up/core/constants/api_const.dart';
import 'package:fork_up/data/home/model/product_model.dart';
import 'package:fork_up/data/whole_sale/data_source/get_products_remote_data_source.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: GetProductsRemoteDataSource)
class GetProductsRemoteDataSourceImpl implements GetProductsRemoteDataSource {
  final Dio dio;

  GetProductsRemoteDataSourceImpl(this.dio);

  @override
  Future<List<Product>> getProducts({int page = 1, int limit = 1000}) async {
    final response = await dio.get(
      ApiConstants.getProducts,
      queryParameters: {"page": page, "per_page": limit},
      options: Options(
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer YOUR_TOKEN",
          "Accept-Language": "en",
        },
      ),
    );

    final data = response.data;

    final productsList = (data['data']?['products'] ?? []) as List;

    final products = productsList.map((e) => Product.fromJson(e)).toList();

    return products;
  }
}
