import 'package:flutter/material.dart';
import 'package:fork_up/core/routing/app_routes.dart';
import 'package:fork_up/presentation/screens/root.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.root,
      routes: {AppRoutes.root: (_) => const Root()},
    );
  }
}
