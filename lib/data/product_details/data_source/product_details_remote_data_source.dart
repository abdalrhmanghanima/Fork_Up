import 'package:fork_up/data/product_details/model/product_model.dart';

abstract class ProductDetailsRemoteDataSource {
  Future<ProductDetailsModel> getProductDetails(String slug);
}
