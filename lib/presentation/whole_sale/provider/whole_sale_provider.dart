import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fork_up/domain/home/entity/product_entity.dart';
import 'package:fork_up/presentation/whole_sale/provider/whole_sale_notifier.dart';

final wholeSaleProvider =
    AsyncNotifierProvider<WholeSaleNotifier, List<ProductEntity>>(
      WholeSaleNotifier.new,
    );
