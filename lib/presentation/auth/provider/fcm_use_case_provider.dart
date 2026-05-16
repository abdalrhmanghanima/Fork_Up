import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fork_up/presentation/auth/provider/send_otp/send_otp_notifier.dart';

import '../../../domain/auth/repository/auth_repo.dart';
import '../../../domain/auth/use_case/store_fcm_token_use_case.dart';

final storeFcmUseCaseProvider = Provider<StoreFcmTokenUseCase>((ref) {
  return StoreFcmTokenUseCase(
    ref.read(authRepoProvider as ProviderListenable<AuthRepo>),
  );
});
