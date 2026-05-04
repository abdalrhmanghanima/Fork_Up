import 'package:fork_up/data/home/model/product_model.dart';

abstract class GetProductsRemoteDataSource {
  Future<List<Product>> getProducts({int page =1,int limit = 1000});
}