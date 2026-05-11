import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fork_up/domain/cart/entity/cart_entity.dart';
import 'package:fork_up/presentation/cart/providers/cart_notifier.dart';

final cartProvider = AsyncNotifierProvider<CartNotifier,List<CartEntity>>(
  CartNotifier.new,
);