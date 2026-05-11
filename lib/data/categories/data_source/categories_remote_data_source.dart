import 'package:fork_up/data/categories/model/categories_response_model.dart';
abstract class CategoriesRemoteDataSource {
  Future<CategoriesResponseModel> getCategories();
}