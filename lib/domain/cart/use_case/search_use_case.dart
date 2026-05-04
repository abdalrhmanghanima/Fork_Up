import 'package:fork_up/domain/home/entity/product_entity.dart';
import 'package:fork_up/domain/home/repository/home_repo.dart';
import 'package:injectable/injectable.dart';
@lazySingleton
class SearchUseCase {
  final HomeRepo homeRepo;

  SearchUseCase(this.homeRepo);

  Future<List<ProductEntity>> call(String query) async {
    final homeData = await homeRepo.getHomeData();

    final products = {
      ...homeData.data.newArrivalProducts,
      ...homeData.data.bestSellers,
    }.toList();

    return products.where((product) {
      return product.name
          .toLowerCase()
          .contains(query.toLowerCase());
    }).toList();
  }
}