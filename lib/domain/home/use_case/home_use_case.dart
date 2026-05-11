import 'package:fork_up/domain/home/entity/home_entity.dart';
import 'package:fork_up/domain/home/repository/home_repo.dart';

class GetHomeDataUseCase {
  final CategoriesRepo homeRepo;
  GetHomeDataUseCase(this.homeRepo);
  Future<HomeEntity> call() {
    return homeRepo.getHomeData();
  }
}
