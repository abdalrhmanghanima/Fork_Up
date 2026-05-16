import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fork_up/presentation/auth/provider/log_out/log_out_notifier.dart';

final logoutProvider = StateNotifierProvider<LogoutNotifier, AsyncValue<void>>((
  ref,
) {
  return LogoutNotifier(ref.read(logOutUseCaseProvider));
});
