import 'package:dio/dio.dart';
import 'package:fork_up/core/constants/api_const.dart';
import 'package:fork_up/data/auth/data_source/auth_remote_data_source.dart';
import 'package:fork_up/data/auth/model/register_model.dart';
import 'package:fork_up/data/auth/model/send_otp_model.dart';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final Dio dio;
  AuthRemoteDataSourceImpl(this.dio);
  @override
  Future<SendOtpModel> sendOtp({required String phone}) async {
    final formData = FormData.fromMap({"phone": phone});
    final response = await dio.post(ApiConstants.sendOtp, data: formData);
    if (response.data is Map<String, dynamic>) {
      return SendOtpModel.fromJson(response.data as Map<String, dynamic>);
    } else {
      throw Exception("Invalid server response");
    }
  }

  @override
  Future<RegisterModel> createAccount({
    required String phone,
    required String firstName,
    required String lastName,
  })async {
    final formData = FormData.fromMap({
      "phone": phone,
      "first_name": firstName,
      "last_name": lastName,
    });
    final response = await dio.post(ApiConstants.createAccount,data: formData);
    if (response.data is Map<String, dynamic>) {
      return RegisterModel.fromJson(response.data as Map<String, dynamic>);
    } else {
      throw Exception("Invalid server response");
    }
  }
}
