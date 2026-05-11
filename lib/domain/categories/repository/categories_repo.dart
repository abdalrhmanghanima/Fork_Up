import 'package:fork_up/domain/home/entity/category_entity.dart';
abstract class CategoriesRepo{
  Future<CategoriesResponseEntity> getCategories();
}