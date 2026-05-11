import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final dioProvider = Provider<Dio>((ref) {
  return Dio();
});
final sharedPrefsProvider =
Provider<SharedPreferences>((ref) {
  throw UnimplementedError();
});