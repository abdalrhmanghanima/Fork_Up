import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fork_up/domain/auth/use_case/remove_token_use_case.dart';
import 'package:fork_up/presentation/auth/provider/remove_token/remove_token_notifier.dart';
import 'package:fork_up/presentation/auth/provider/send_otp/send_otp_notifier.dart';

final removeTokenNotifierProvider =
    StateNotifierProvider<RemoveTokenNotifier, AsyncValue<void>>((ref) {
      return RemoveTokenNotifier(ref.read(removeTokenUseCaseProvider));
    });

final removeTokenUseCaseProvider = Provider<RemoveTokenUseCase>((ref) {
  return RemoveTokenUseCase(ref.read(authRepoProvider));
});
