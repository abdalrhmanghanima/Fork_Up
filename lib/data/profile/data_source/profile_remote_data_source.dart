import 'dart:io';

import 'package:fork_up/data/auth/model/user_model.dart';

abstract class ProfileRemoteDataSource {
  Future<UserModel> getProfile();
  Future<UserModel> updateProfile({
    required String firstName,
    required String lastName,
    File? image,
    String? phone,
    String? email,
  });
}
