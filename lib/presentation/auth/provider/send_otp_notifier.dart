import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fork_up/core/providers/app_provider.dart';
import 'package:fork_up/data/auth/data_source/auth_remote_data_source.dart';
import 'package:fork_up/data/auth/data_source/auth_remote_data_source_impl.dart';
import 'package:fork_up/data/auth/repository/auth_repo_impl.dart';
import 'package:fork_up/domain/auth/entity/send_otp_entity.dart';
import 'package:fork_up/domain/auth/repository/auth_repo.dart';
import 'package:fork_up/domain/auth/use_case/send_otp_use_case.dart';

class SendOtpNotifier extends AsyncNotifier<SendOtpEntity?>{
  @override
  Future<SendOtpEntity?> build() async {
    return null;
  }

  Future<void> sendOtp({required String phone}) async {

    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {

      final useCase = ref.read(sendOtpUseCaseProvider);

      return await useCase(phone: phone);

    });

  }
}
final authRemoteDataProvider= Provider<AuthRemoteDataSource>((ref){
  return AuthRemoteDataSourceImpl(ref.read(dioProvider));
});
final authRepoProvider = Provider<AuthRepo>((ref){
  return AuthRepoImpl(ref.read(authRemoteDataProvider));
});
final sendOtpUseCaseProvider = Provider<SendOtpUseCase>((ref){
  return SendOtpUseCase(ref.read(authRepoProvider));
});
final otpProvider = StateProvider<String>((ref) => '');