import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fork_up/core/di/di.dart';
import 'package:fork_up/core/routing/app_routes.dart';
import 'package:fork_up/domain/recently_viewed/use_case/add_product.dart';
import 'package:fork_up/domain/recently_viewed/use_case/get_recently_products.dart';
import 'package:fork_up/presentation/cart/cubit/cart_cubit.dart';
import 'package:fork_up/presentation/home/cubit/home_cubit.dart';
import 'package:fork_up/presentation/root.dart';
import 'package:fork_up/presentation/shared/cubit/recently_viewed_cubit.dart';
final Dio dio = Dio();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  dio.interceptors.add(LogInterceptor(
    request: true,
    requestBody: true,
    responseBody: true,
    error: true,
  ));
  await init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => sl<HomeCubit>()..getHomeData(),
        ),
        BlocProvider(
          create: (context) => RecentlyViewedCubit(
              sl<GetRecentlyViewedUseCase>(),
              sl<AddRecentlyViewedUseCase>(),
          )..load(),
        ),
        BlocProvider(
          create: (_) => sl<CartCubit>(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: AppRoutes.root,
        routes: {
          AppRoutes.root: (_) => const Root(),
        },
      ),
    );
  }
}
