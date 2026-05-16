import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fork_up/data/auth/data_source/auth_local_data_source.dart';

class CheckLoginNotifier extends StateNotifier<bool> {
  final AuthLocalDataSource authLocalDataSource;

  CheckLoginNotifier(this.authLocalDataSource) : super(false);

  Future<void> checkLogin() async {
    state = await authLocalDataSource.isLoggedIn();
  }
}
