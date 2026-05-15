import 'package:fork_up/data/auth/data_source/auth_remote_data_source.dart';
import 'package:fork_up/domain/auth/entity/register_entity.dart';
import 'package:fork_up/domain/auth/entity/send_otp_entity.dart';
import 'package:fork_up/domain/auth/repository/auth_repo.dart';

class AuthRepoImpl implements AuthRepo {
  final AuthRemoteDataSource authRemoteDataSource;
  AuthRepoImpl(this.authRemoteDataSource);
  @override
  Future<SendOtpEntity> sendOtp({required String phone}) {
    return authRemoteDataSource.sendOtp(phone: phone);
  }

  @override
  Future<RegisterEntity> createAccount({
    required String phone,
    required String firstName,
    required String lastName,
  }) {
    return authRemoteDataSource.createAccount(
      phone: phone,
      firstName: firstName,
      lastName: lastName,
    );
  }
}
