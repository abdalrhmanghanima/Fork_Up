import 'package:fork_up/data/auth/model/user_model.dart';
import 'package:fork_up/domain/auth/entity/send_otp_entity.dart';

class SendOtpModel extends SendOtpEntity {
  SendOtpModel({
    required super.status,
    required super.message,
    required super.otp,
    required super.user,
  });

  factory SendOtpModel.fromJson(Map<String, dynamic> json) {
    return SendOtpModel(
      status: json['status'],
      message: json['msg'],
      otp: json['otp'].toString(),
      user: json['data'] != null ? UserModel.fromJson(json['data']) : null,
    );
  }
}
