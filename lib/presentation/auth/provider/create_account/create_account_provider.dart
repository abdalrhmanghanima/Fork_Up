import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fork_up/domain/auth/entity/register_entity.dart';
import 'package:fork_up/presentation/auth/provider/create_account/create_account_notifier.dart';

final createAccountProvider =
    AsyncNotifierProvider<CreateAccountNotifier, RegisterEntity?>(
      CreateAccountNotifier.new,
    );
