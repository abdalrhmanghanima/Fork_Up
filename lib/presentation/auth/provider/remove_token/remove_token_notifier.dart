import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fork_up/domain/auth/use_case/remove_token_use_case.dart';

class RemoveTokenNotifier extends StateNotifier<AsyncValue<void>> {
  final RemoveTokenUseCase removeTokenUseCase;

  RemoveTokenNotifier(this.removeTokenUseCase) : super(const AsyncData(null));

  Future<void> removeToken() async {
    state = const AsyncLoading();

    try {
      await removeTokenUseCase.call();

      state = const AsyncData(null);
    } catch (e, s) {
      state = AsyncError(e, s);
    }
  }
}
