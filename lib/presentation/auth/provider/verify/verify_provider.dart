import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fork_up/presentation/auth/provider/verify/verify_notifier.dart';
final verifyProvider =
AsyncNotifierProvider<VerifyNotifier, void>(
  VerifyNotifier.new,
);