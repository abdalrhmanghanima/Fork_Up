import 'package:fork_up/domain/home/entity/home_entity.dart';

abstract class CategoriesRepo {
  Future<HomeEntity> getHomeData();
}
