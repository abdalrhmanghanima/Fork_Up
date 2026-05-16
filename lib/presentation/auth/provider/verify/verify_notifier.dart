import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class VerifyNotifier extends AsyncNotifier<void> {
  @override
  FutureOr<void> build() {}

  Future<void> verify(Future<void> Function() action) async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      await action();
    });
  }
}
