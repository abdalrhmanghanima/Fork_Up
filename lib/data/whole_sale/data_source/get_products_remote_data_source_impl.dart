import 'package:dio/dio.dart';
import 'package:fork_up/core/constants/api_const.dart';
import 'package:fork_up/data/home/model/product_model.dart';
import 'package:fork_up/data/whole_sale/data_source/get_products_remote_data_source.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetProductsRemoteDataSourceImpl implements GetProductsRemoteDataSource {
  final Dio dio;
  GetProductsRemoteDataSourceImpl(this.dio);

  @override
  Future<List<Product>> getProducts({
    int page = 1,
    int limit = 1000,
    int? categoryId,
    int? subCategoryId,
  }) async {
    final prefs = await SharedPreferences.getInstance();

    final token = prefs.getString("token");
    final response = await dio.get(
      ApiConstants.getProducts,
      queryParameters: {
        "page_number": page,
        "products_per_page": limit,
        "is_wholesale": 1,

        if (categoryId != null) "category_id": categoryId,

        if (subCategoryId != null) "category_id": subCategoryId,
      },

      options: Options(
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer $token",
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
