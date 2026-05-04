import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fork_up/domain/cart/use_case/search_use_case.dart';
import 'package:fork_up/presentation/cart/cubit/search_state.dart';
import 'package:injectable/injectable.dart';

@injectable
class SearchCubit extends Cubit<SearchState> {
  final SearchUseCase searchUseCase;
  SearchCubit(this.searchUseCase) : super(SearchInitial());
  Future<void> search(String query) async {
    if (query.isEmpty) {
      emit(SearchInitial());
      return;
    }
    emit(SearchLoading());
    try {
      final result = await searchUseCase(query);
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
