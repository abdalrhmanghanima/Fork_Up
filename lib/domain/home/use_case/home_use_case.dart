import 'package:fork_up/domain/home/entity/home_entity.dart';
import 'package:fork_up/domain/home/repository/home_repo.dart';
import 'package:injectable/injectable.dart';
@lazySingleton
class GetHomeDataUseCase {
  final HomeRepo homeRepo;
  GetHomeDataUseCase(this.homeRepo);
  Future<HomeEntity> call() {
    return homeRepo.getHomeData();
  }
}
