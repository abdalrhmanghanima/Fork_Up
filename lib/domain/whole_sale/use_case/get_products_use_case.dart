import 'package:fork_up/domain/home/entity/product_entity.dart';
import 'package:fork_up/domain/whole_sale/repository/get_products_repo.dart';

class GetProductsUseCase {
  final GetProductsRepo productRepo;

  GetProductsUseCase(this.productRepo);

  Future<List<ProductEntity>> call({
    required int page,
    int? categoryId,
    int? subCategoryId,
  }) {
    return productRepo.getProducts(
      page: page,
      categoryId: categoryId,
      subCategoryId: subCategoryId,
    );
  }
}
