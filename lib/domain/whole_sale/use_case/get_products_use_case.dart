import 'package:fork_up/domain/home/entity/product_entity.dart';
import 'package:fork_up/domain/whole_sale/repository/get_products_repo.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetProductsUseCase {
  final GetProductsRepo productRepo;

  GetProductsUseCase(this.productRepo);

  Future<List<ProductEntity>> call({int page = 1}) {
    return productRepo.getProducts();
  }
}
