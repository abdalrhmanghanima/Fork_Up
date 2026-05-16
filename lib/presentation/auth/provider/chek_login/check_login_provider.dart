import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fork_up/presentation/auth/provider/chek_login/check_login_notifier.dart';
import 'package:fork_up/presentation/auth/provider/local_data_source_provider.dart';

final checkLoginProvider = StateNotifierProvider<CheckLoginNotifier, bool>((
  ref,
) {
  return CheckLoginNotifier(ref.read(authLocalDataSourceProvider));
});
