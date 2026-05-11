import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fork_up/core/providers/app_provider.dart';
import 'package:fork_up/data/home/data_source/home_remote_data_source.dart';
import 'package:fork_up/data/home/data_source/home_remote_data_source_impl.dart';
import 'package:fork_up/data/home/repository/home_repo_impl.dart';
import 'package:fork_up/domain/home/entity/home_entity.dart';
import 'package:fork_up/domain/home/repository/home_repo.dart';
import 'package:fork_up/domain/home/use_case/home_use_case.dart';

class HomeNotifier extends AsyncNotifier<HomeEntity> {
  @override
  Future<HomeEntity> build() async {
    return getHomeData();
  }

  Future<HomeEntity> getHomeData() async {
    final useCase = ref.read(getHomeDataUseCaseProvider);

    return await useCase();
  }
}
final homeRemoteDataSourceProvider =
Provider<HomeRemoteDataSource>((ref) {
  return HomeRemoteDataSourceImpl(
    ref.read(dioProvider),
  );
});

final homeRepoProvider =
Provider<HomeRepo>((ref) {
  return HomeRepositoryImpl(
    ref.read(homeRemoteDataSourceProvider),
  );
});

final getHomeDataUseCaseProvider =
Provider<GetHomeDataUseCase>((ref) {
  return GetHomeDataUseCase(
    ref.read(homeRepoProvider),
  );
});
