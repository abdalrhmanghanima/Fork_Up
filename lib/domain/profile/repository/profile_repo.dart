import 'dart:io';
import 'package:fork_up/domain/auth/entity/user_entity.dart';

abstract class ProfileRepo {
  Future<UserEntity> getProfile();
  Future<UserEntity> updateProfile({
    required String firstName,
    required String lastName,
    File? image,
    String? phone,
    String? email,
  });
}
