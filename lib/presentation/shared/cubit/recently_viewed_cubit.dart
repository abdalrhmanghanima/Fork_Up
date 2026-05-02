import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fork_up/domain/home/entity/product_entity.dart';
import 'package:fork_up/domain/recently_viewed/use_case/add_product.dart';
import 'package:fork_up/domain/recently_viewed/use_case/get_recently_products.dart';
import 'package:fork_up/presentation/shared/cubit/recently_viewed_state.dart';
import 'package:injectable/injectable.dart';
@injectable
class RecentlyViewedCubit extends Cubit<RecentlyViewedState> {
  final GetRecentlyViewedUseCase getUseCase;
  final AddRecentlyViewedUseCase addUseCase;

  RecentlyViewedCubit(this.getUseCase, this.addUseCase)
      : super(RecentlyViewedState(products: []));

  Future<void> load() async {
    final products = await getUseCase();
    emit(state.copyWith(products: products));
  }

  Future<void> add(ProductEntity product) async {
    await addUseCase(product);
    await load(); // refresh
  }
}