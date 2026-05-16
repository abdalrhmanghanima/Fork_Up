import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fork_up/data/auth/data_source/auth_local_data_source.dart';
import 'package:fork_up/data/auth/data_source/auth_local_data_source_impl.dart';

final authLocalDataSourceProvider = Provider<AuthLocalDataSource>((ref) {
  return AuthLocalDataSourceImpl();
});
