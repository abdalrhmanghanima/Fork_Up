import 'package:fork_up/data/auth/data_source/auth_local_data_source.dart';
import 'package:fork_up/data/auth/data_source/auth_remote_data_source.dart';
import 'package:fork_up/domain/auth/entity/register_entity.dart';
import 'package:fork_up/domain/auth/entity/send_otp_entity.dart';
import 'package:fork_up/domain/auth/repository/auth_repo.dart';

class AuthRepoImpl implements AuthRepo {
  final AuthRemoteDataSource authRemoteDataSource;
  final AuthLocalDataSource localDataSource;
  AuthRepoImpl(this.authRemoteDataSource, this.localDataSource);
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

  @override
  Future<void> logout() async {
    await authRemoteDataSource.logout();
    await localDataSource.removeToken();
  }

  @override
  Future<void> storeFcmToken() async {
    await authRemoteDataSource.storeFcmToken();
  }

  @override
  Future<void> removeToken() async {
    await localDataSource.removeToken();
  }
}
