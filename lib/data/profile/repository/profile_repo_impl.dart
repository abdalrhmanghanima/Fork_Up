import 'dart:io';

import 'package:fork_up/data/profile/data_source/profile_remote_data_source.dart';
import 'package:fork_up/domain/auth/entity/user_entity.dart';
import 'package:fork_up/domain/profile/repository/profile_repo.dart';

class ProfileRepoImpl implements ProfileRepo {
  ProfileRemoteDataSource profileRemoteDataSource;
  ProfileRepoImpl(this.profileRemoteDataSource);
  @override
  Future<UserEntity> getProfile() {
    final result = profileRemoteDataSource.getProfile();
    return result;
  }

  @override
  Future<UserEntity> updateProfile({
    required String firstName,
    required String lastName,
    File? image,
    String? phone,
    String? email,
  }) {
    final result = profileRemoteDataSource.updateProfile(
      firstName: firstName,
      lastName: lastName,
      image: image,
      phone: phone,
      email: email,
    );
    return result;
  }
}
