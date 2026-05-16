import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fork_up/domain/home/entity/home_entity.dart';
import 'package:fork_up/presentation/home/providers/home_notifier.dart';

final homeProvider = AsyncNotifierProvider<HomeNotifier, HomeEntity>(
  HomeNotifier.new,
);
