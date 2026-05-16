import 'package:fork_up/domain/auth/entity/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({
    required super.id,
    required super.firstName,
    required super.lastName,
    required super.username,
    required super.phone,
    required super.address,
    required super.image,
    required super.email,
    required super.token,
    required super.notificationCount,
    required super.isRegistered,
    required super.isFirstOrder,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      firstName: json['first_name'] ?? "",
      lastName: json['last_name'] ?? "",
      username: json['username'],
      phone: json['phone'] ?? "",
      address: json['address'] ?? "",
      image: json['image'],
      email: json['email']?.toString(),
      token: json['token'] ?? "",
      notificationCount: json['notification_count'],
      isRegistered: json['is_registered'] ?? false,
      isFirstOrder: json['is_first_order'],
    );
  }
}
