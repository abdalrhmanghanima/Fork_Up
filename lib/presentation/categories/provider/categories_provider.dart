import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fork_up/domain/home/entity/category_entity.dart';
import 'package:fork_up/presentation/categories/provider/categories_notifier.dart';

final categoriesProvider =
    AsyncNotifierProvider<CategoriesNotifier, CategoriesResponseEntity>(
      CategoriesNotifier.new,
    );
