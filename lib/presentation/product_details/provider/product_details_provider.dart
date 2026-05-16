import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fork_up/domain/product_details/entity/product_details_entity.dart';
import 'package:fork_up/presentation/product_details/provider/product_details_notifier.dart';

final productDetailsProvider =
    AsyncNotifierProviderFamily<
      ProductDetailsNotifier,
      ProductDetailsEntity,
      String
    >(ProductDetailsNotifier.new);
