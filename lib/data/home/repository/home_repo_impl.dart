import 'package:fork_up/data/home/data_source/home_remote_data_source.dart';
import 'package:fork_up/data/home/model/mapper/home_mapper.dart';
import 'package:fork_up/domain/home/entity/home_entity.dart';
import 'package:fork_up/domain/home/repository/home_repo.dart';
class HomeRepositoryImpl implements HomeRepo {
  final HomeRemoteDataSource remote;

  HomeRepositoryImpl(this.remote);

  @override
  Future<HomeEntity> getHomeData() async {
    final result = await remote.getHomeData();
    return result.toEntity();
  }
}