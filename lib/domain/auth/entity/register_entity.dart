import 'package:fork_up/domain/auth/entity/user_entity.dart';

class RegisterEntity {
  final UserEntity user;
  final String msg;
  final int status;

  RegisterEntity({required this.user, required this.msg, required this.status});
}
