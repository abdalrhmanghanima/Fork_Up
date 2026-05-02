import 'package:fork_up/domain/product_details/entity/product_details_entity.dart';
import 'package:fork_up/domain/product_details/repository/product_repo.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetProductDetailsUseCase {
  final ProductRepo productRepo;

  GetProductDetailsUseCase(this.productRepo);

  Future<ProductDetailsEntity> call(String slug) {
    print("🧠 USECASE CALLED WITH: $slug");
    return productRepo.getProductDetails(slug);
  }
}