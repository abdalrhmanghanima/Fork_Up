import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fork_up/domain/home/use_case/home_use_case.dart';
import 'package:fork_up/presentation/home/cubit/home_state.dart';
import 'package:injectable/injectable.dart';
@injectable
class HomeCubit extends Cubit<HomeState> {
  final GetHomeDataUseCase useCase;
  HomeCubit(this.useCase) : super(HomeInitial());
  Future<void> getHomeData() async {
    emit(HomeLoading());
    try {
      final result = await useCase();
      emit(HomeSuccess(result));
    } catch (e, s) {
      print("🔥 ERROR: $e");
      print("🔥 STACK: $s");
      emit(HomeError(e.toString()));
    }
  }
}
