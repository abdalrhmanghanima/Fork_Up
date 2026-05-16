import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fork_up/domain/auth/entity/register_entity.dart';
import 'package:fork_up/domain/auth/use_case/create_account_use_case.dart';
import 'package:fork_up/presentation/auth/provider/send_otp/send_otp_notifier.dart';

class CreateAccountNotifier extends AsyncNotifier<RegisterEntity?> {
  @override
  Future<RegisterEntity?> build() async {
    return null;
  }

  Future<void> createAccount({
    required String phone,
    required String firstName,
    required String lastName,
  }) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final useCase = ref.read(createAccountUseCaseProvider);
      return await useCase(
        phone: phone,
        firstName: firstName,
        lastName: lastName,
      );
    });
  }
}

final createAccountUseCaseProvider = Provider<CreateAccountUseCase>((ref) {
  return CreateAccountUseCase(ref.read(authRepoProvider));
});
