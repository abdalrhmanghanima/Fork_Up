import 'package:fork_up/data/auth/data_source/auth_local_data_source.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthLocalDataSourceImpl
    implements AuthLocalDataSource {

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

}