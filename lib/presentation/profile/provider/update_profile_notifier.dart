import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fork_up/domain/auth/entity/user_entity.dart';
import 'package:fork_up/domain/profile/use_case/update_profile_use_case.dart';
import 'package:fork_up/presentation/profile/provider/get_profile_notifier.dart';

class UpdateProfileNotifier extends AsyncNotifier<void> {
  @override
  Future<void> build() async {}
  Future<UserEntity> updateProfile({
    required String firstName,
    required String lastName,
    File? image,
    String? phone,
    String? email,
  }) async {
    state = const AsyncLoading();
    final useCase = ref.watch(updateProfileUseCaseProvider);
    return await useCase(
      firstName: firstName,
      lastName: lastName,
      image: image,
      phone: phone,
      email: email,
    );
  }
}

final updateProfileUseCaseProvider = Provider<UpdateProfileUseCase>((ref) {
  return UpdateProfileUseCase(ref.read(profileRepoProvider));
});
