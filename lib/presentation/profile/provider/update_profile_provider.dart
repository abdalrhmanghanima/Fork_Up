import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fork_up/presentation/profile/provider/update_profile_notifier.dart';

final updateProfileProvider =
    AsyncNotifierProvider<UpdateProfileNotifier, void>(
      UpdateProfileNotifier.new,
    );
