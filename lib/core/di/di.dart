import 'package:dio/dio.dart';
import 'package:fork_up/core/di/di.config.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';


final sl = GetIt.instance;

@InjectableInit()
Future<void> init() async {
  sl.init();
}

@module
abstract class RegisterModule {
  @lazySingleton
  Dio dio() => Dio();
}