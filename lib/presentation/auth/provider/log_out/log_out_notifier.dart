import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fork_up/domain/auth/use_case/log_out_use_case.dart';
import 'package:fork_up/presentation/auth/provider/send_otp/send_otp_notifier.dart';

class LogoutNotifier extends StateNotifier<AsyncValue<void>> {
  final LogoutUseCase logoutUseCase;

  LogoutNotifier(this.logoutUseCase) : super(const AsyncData(null));

  Future<void> logout() async {
    state = const AsyncLoading();

    try {
      await logoutUseCase.call();

      state = const AsyncData(null);
    } catch (e, s) {
      state = AsyncError(e, s);
    }
  }
}

final logOutUseCaseProvider = Provider<LogoutUseCase>(
  (ref) => LogoutUseCase(ref.read(authRepoProvider)),
);
