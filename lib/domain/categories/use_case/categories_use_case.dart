import 'package:fork_up/domain/categories/repository/categories_repo.dart';
import 'package:fork_up/domain/home/entity/category_entity.dart';

class GetCategoriesUseCase {
  final CategoriesRepo categoriesRepo;
  GetCategoriesUseCase(this.categoriesRepo);
  Future<CategoriesResponseEntity> call() {
    return categoriesRepo.getCategories();
  }
}
