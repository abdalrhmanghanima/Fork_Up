import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fork_up/domain/home/entity/product_entity.dart';
import 'package:fork_up/presentation/whole_sale/cubit/whole_sale_state.dart';
import 'package:injectable/injectable.dart';
import 'package:fork_up/domain/whole_sale/use_case/get_products_use_case.dart';


@injectable
class WholeSaleCubit extends Cubit<WholeSaleState> {
  final GetProductsUseCase getProductsUseCase;
  int currentPage = 1;
  bool isLoadingMore = false;
  bool hasMore = true;

  List<ProductEntity> allProducts = [];

  WholeSaleCubit(this.getProductsUseCase)
      : super(WholeSaleInitial());

  Future<void> getProducts() async {
    emit(WholeSaleLoading());

    try {
      final products = await getProductsUseCase(page: 1);

      allProducts = products;
      currentPage = 1;
      hasMore = products.length == 15;

      emit(WholeSaleSuccess(allProducts));
    } catch (e) {
      emit(WholeSaleError(e.toString()));
    }
  }
  Future<void> loadMore() async {
    if (isLoadingMore || !hasMore) return;

    isLoadingMore = true;
    currentPage++;

    try {
      final products = await getProductsUseCase(page: currentPage);

      if (products.isEmpty) {
        hasMore = false;
      } else {
        allProducts.addAll(products);
      }

      emit(WholeSaleSuccess(List.from(allProducts)));
    } catch (e) {
      emit(WholeSaleError(e.toString()));
    }

    isLoadingMore = false;
  }
}