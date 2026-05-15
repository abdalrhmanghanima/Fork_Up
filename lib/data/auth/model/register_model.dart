import 'package:fork_up/data/auth/model/user_model.dart';
import 'package:fork_up/domain/auth/entity/register_entity.dart';

class RegisterModel extends RegisterEntity {
  RegisterModel({
    required super.user,
    required super.msg,
    required super.status,
  });

  factory RegisterModel.fromJson(Map<String, dynamic> json) {
    return RegisterModel(
      user: UserModel.fromJson(json['data']),
      msg: json['msg'],
      status: json['status'],
    );
  }
}