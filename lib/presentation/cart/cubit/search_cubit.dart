import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fork_up/domain/cart/use_case/search_use_case.dart';
import 'package:fork_up/domain/home/entity/product_entity.dart';
import 'package:fork_up/presentation/cart/cubit/search_state.dart';
import 'package:injectable/injectable.dart';

@injectable
class SearchCubit extends Cubit<SearchState> {
  final SearchUseCase searchUseCase;

  List<ProductEntity> allProducts = [];

  SearchCubit(this.searchUseCase) : super(SearchInitial());

  Future<void> initProducts() async {
    allProducts = await searchUseCase.getAllProducts(); // نجيب مرة واحدة بس
  }

  Future<void> search(String query) async {
    if (query.isEmpty) {
      emit(SearchInitial());
      return;
    }

    emit(SearchLoading());

    try {
      final result = allProducts.where((product) {
        return product.name
            .toLowerCase()
            .contains(query.toLowerCase());
      }).toList();

      if (result.isEmpty) {
        emit(SearchEmpty());
      } else {
        emit(SearchLoaded(result));
      }
    } catch (e) {
      emit(SearchError(e.toString()));
    }
  }
}
