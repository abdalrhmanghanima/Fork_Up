import 'package:dio/dio.dart';
import 'package:fork_up/core/di/di.config.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';


final sl = GetIt.instance;

@InjectableInit()
Future<void> init() async {
  await sl.init();
}

@module
abstract class RegisterModule {
  @lazySingleton
  Dio dio() => Dio();
  @preResolve
  Future<SharedPreferences> prefs() async =>
      await SharedPreferences.getInstance();
}