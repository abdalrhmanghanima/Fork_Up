import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fork_up/domain/home/entity/product_entity.dart';
import 'package:fork_up/presentation/shared/provider/recently_viewed_notifier.dart';

final recentlyViewedProvider =
    AsyncNotifierProvider<RecentlyViewedNotifier, List<ProductEntity>>(
      RecentlyViewedNotifier.new,
    );
