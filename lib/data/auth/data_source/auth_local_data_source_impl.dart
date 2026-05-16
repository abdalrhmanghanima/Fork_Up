import 'package:fork_up/data/auth/data_source/auth_local_data_source.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  @override
  Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString('token', token);
  }

  @override
  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getString('token');
  }

  @override
  Future<void> removeToken() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.remove('token');
  }

  @override
  Future<void> saveDeviceToken(String token) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString('device_token', token);
  }

  @override
  Future<String?> getDeviceToken() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getString('device_token');
  }

  @override
  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();

    final token = prefs.getString("token");

    return token != null && token.isNotEmpty;
  }
}
