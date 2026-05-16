import 'dart:io';

import 'package:dio/dio.dart';
import 'package:fork_up/core/constants/api_const.dart';
import 'package:fork_up/data/auth/model/user_model.dart';
import 'package:fork_up/data/profile/data_source/profile_remote_data_source.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  final Dio dio;
  ProfileRemoteDataSourceImpl(this.dio);
  @override
  Future<UserModel> getProfile() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token");
    final response = await dio.get(
      ApiConstants.getProfile,
      options: Options(
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer $token",
        },
      ),
    );
    print(response);
    return UserModel.fromJson(response.data["data"]);
  }

  @override
  Future<UserModel> updateProfile({
    required String firstName,
    required String lastName,
    File? image,
    String? phone,
    String? email,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token");
    final formData = FormData.fromMap({
      "first_name": firstName,
      "last_name": lastName,
      if (phone != null) "phone": phone,

      if (email != null) "email": email,

      if (image != null) "image": await MultipartFile.fromFile(image.path),
    });
    final response = await dio.post(
      ApiConstants.updateProfile,
      data: formData,
      options: Options(
        headers: {"Accept": "application/json", "Authorization": token},
      ),
    );
    print(response);
    final data = response.data["data"];

    if (data == null) {
      throw Exception(response.data["message"]);
    }

    return UserModel.fromJson(data);
  }
}
