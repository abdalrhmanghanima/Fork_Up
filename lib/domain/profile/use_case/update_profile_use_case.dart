import 'dart:io';

import 'package:fork_up/domain/auth/entity/user_entity.dart';
import 'package:fork_up/domain/profile/repository/profile_repo.dart';

class UpdateProfileUseCase {
  ProfileRepo profileRepo;
  UpdateProfileUseCase(this.profileRepo);
  Future<UserEntity> call({
    required String firstName,
    required String lastName,
    File? image,
    String? phone,
    String? email,
  }) {
    return profileRepo.updateProfile(
      firstName: firstName,
      lastName: lastName,
      image: image,
      phone: phone,
      email: email,
    );
  }
}
