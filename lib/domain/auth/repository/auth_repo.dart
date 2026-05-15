import 'package:fork_up/domain/auth/entity/register_entity.dart';
import 'package:fork_up/domain/auth/entity/send_otp_entity.dart';

abstract class AuthRepo {
  Future<SendOtpEntity> sendOtp({required String phone});
  Future<RegisterEntity> createAccount({
    required String phone,
    required String firstName,
    required String lastName,
  });
}
