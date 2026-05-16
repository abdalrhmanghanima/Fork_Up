import 'package:fork_up/domain/auth/entity/user_entity.dart';

class SendOtpEntity {
  final int status;
  final String message;
  final String otp;
  final UserEntity? user;

  SendOtpEntity({
    required this.status,
    required this.message,
    required this.otp,
    required this.user,
  });
}
