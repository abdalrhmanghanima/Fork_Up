import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fork_up/core/di/di.dart';
import 'package:fork_up/core/routing/app_routes.dart';
import 'package:fork_up/presentation/home/cubit/home_cubit.dart';
import 'package:fork_up/presentation/root.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<HomeCubit>()..getHomeData(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: AppRoutes.root,
        routes: {AppRoutes.root: (_) => const Root()},
      ),
    );
  }
}
