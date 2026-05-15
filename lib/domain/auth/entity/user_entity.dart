class UserEntity {
  final int id;
  final String firstName;
  final String lastName;
  final String username;
  final String phone;
  final dynamic address;
  final String? image;
  final dynamic email;
  final String token;
  final int notificationCount;
  final bool isRegistered;
  final int? isFirstOrder;

  UserEntity({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.username,
    required this.phone,
    required this.address,
    required this.image,
    required this.email,
    required this.token,
    required this.notificationCount,
    required this.isRegistered,
    required this.isFirstOrder,
  });
}