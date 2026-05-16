import 'package:fork_up/domain/home/entity/product_entity.dart';
import 'package:fork_up/domain/whole_sale/repository/get_products_repo.dart';

class SearchUseCase {
  final GetProductsRepo productsRepo;

  SearchUseCase(this.productsRepo);
  Future<List<ProductEntity>> getAllProducts() {
    return productsRepo.getProducts(page: 1);
  }
}
