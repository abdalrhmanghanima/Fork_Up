import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fork_up/domain/home/entity/product_entity.dart';
import 'package:fork_up/presentation/cart/providers/search_notifier.dart';

final searchProvider =
    AsyncNotifierProvider<SearchNotifier, List<ProductEntity>>(
      SearchNotifier.new,
    );
