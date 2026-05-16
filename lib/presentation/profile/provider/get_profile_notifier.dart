import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fork_up/core/providers/app_provider.dart';
import 'package:fork_up/data/profile/data_source/profile_remote_data_source.dart';
import 'package:fork_up/data/profile/data_source/profile_remote_data_source_impl.dart';
import 'package:fork_up/data/profile/repository/profile_repo_impl.dart';
import 'package:fork_up/domain/auth/entity/user_entity.dart';
import 'package:fork_up/domain/profile/repository/profile_repo.dart';
import 'package:fork_up/domain/profile/use_case/get_profile_use_case.dart';

class GetProfileNotifier extends AsyncNotifier<UserEntity> {
  @override
  Future<UserEntity> build() {
    return getProfile();
  }

  Future<UserEntity> getProfile() async {
    final useCase = ref.watch(getProfileUseCaseProvider);
    return await useCase();
  }
}

final profileDataSourceProvider = Provider<ProfileRemoteDataSource>((ref) {
  return ProfileRemoteDataSourceImpl(ref.read(dioProvider));
});
final profileRepoProvider = Provider<ProfileRepo>((ref) {
  return ProfileRepoImpl(ref.read(profileDataSourceProvider));
});
final getProfileUseCaseProvider = Provider<GetProfileUseCase>((ref) {
  return GetProfileUseCase(ref.read(profileRepoProvider));
});
