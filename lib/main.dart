import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fork_up/core/providers/app_provider.dart';
import 'package:fork_up/data/cart/model/cart_model.dart';
import 'package:fork_up/domain/cart/entity/cart_product_entity.dart';
import 'package:fork_up/firebase_options.dart';
import 'package:fork_up/presentation/root.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:shared_preferences/shared_preferences.dart';

final Dio dio = Dio();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await Hive.initFlutter();

  Hive.registerAdapter(CartProductEntityAdapter());
  Hive.registerAdapter(CartModelAdapter());

  await Hive.openBox<CartModel>('cartBox');
  final prefs = await SharedPreferences.getInstance();
  dio.interceptors.add(
    LogInterceptor(
      request: true,
      requestBody: true,
      responseBody: true,
      error: true,
    ),
  );
  runApp(
    ProviderScope(
      overrides: [sharedPrefsProvider.overrideWithValue(prefs)],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: const Root());
  }
}
