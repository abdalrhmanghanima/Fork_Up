import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fork_up/domain/product_details/entity/buy_it_together_entity.dart';
import 'package:fork_up/presentation/product_details/provider/buy_it_together/buy_it_together_notifier.dart';

final buyItTogetherProvider = AsyncNotifierProvider.family<BuyItTogetherNotifier,BuyItTogetherEntity,String>(
  BuyItTogetherNotifier.new
);