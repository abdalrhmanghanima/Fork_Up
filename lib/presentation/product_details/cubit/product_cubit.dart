import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fork_up/domain/product_details/use_case/product_use_case.dart';
import 'package:fork_up/presentation/product_details/cubit/product_state.dart';
import 'package:injectable/injectable.dart';

@injectable
class ProductDetailsCubit extends Cubit<ProductState> {
  final GetProductDetailsUseCase useCase;

  ProductDetailsCubit(this.useCase) : super(ProductInitial());

  Future<void> getProductDetails(String slug) async {
    emit(ProductLoading());

    try {
      final result = await useCase(slug);

      emit(ProductSuccess(result));
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }
}
