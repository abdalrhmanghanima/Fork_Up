abstract class AuthLocalDataSource {
  Future<void> saveToken(String token);

  Future<String?> getToken();

  Future<void> removeToken();
  Future<void> saveDeviceToken(String token);

  Future<String?> getDeviceToken();
  Future<bool> isLoggedIn();
}
