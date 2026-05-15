import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fork_up/domain/auth/entity/send_otp_entity.dart';
import 'package:fork_up/presentation/auth/provider/send_otp_notifier.dart';

final sendOtpProvider = AsyncNotifierProvider<SendOtpNotifier,SendOtpEntity?>(
  SendOtpNotifier.new
);