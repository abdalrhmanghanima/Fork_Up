import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fork_up/domain/home/entity/product_entity.dart';
import 'package:fork_up/presentation/wish_list/provider/wish_list_notifier.dart';

final wishlistProvider =
NotifierProvider<
    WishlistNotifier,
    List<ProductEntity>
>(
  WishlistNotifier.new,
);