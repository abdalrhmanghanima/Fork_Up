import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fork_up/domain/auth/entity/user_entity.dart';
import 'package:fork_up/presentation/profile/provider/get_profile_notifier.dart';

final getProfileProvider =
    AsyncNotifierProvider<GetProfileNotifier, UserEntity>(
      GetProfileNotifier.new,
    );
