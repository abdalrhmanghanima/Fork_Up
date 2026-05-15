import 'package:fork_up/domain/auth/entity/send_otp_entity.dart';
import 'package:fork_up/domain/auth/repository/auth_repo.dart';

class SendOtpUseCase {
  final AuthRepo authRepo;
  SendOtpUseCase(this.authRepo);
  Future<SendOtpEntity> call({required String phone}) {
    return authRepo.sendOtp(phone: phone);
  }
}
