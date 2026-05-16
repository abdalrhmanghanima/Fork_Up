import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fork_up/presentation/auth/provider/local_data_source_provider.dart';

final tokenProvider = FutureProvider<String?>((ref) async {
  return await ref.read(authLocalDataSourceProvider).getToken();
});
