import 'package:fork_up/data/auth/model/register_model.dart';
import 'package:fork_up/data/auth/model/send_otp_model.dart';

abstract class AuthRemoteDataSource {
  Future<SendOtpModel> sendOtp({required String phone});
  Future<RegisterModel> createAccount({required String phone,required String firstName,required String lastName});
}
