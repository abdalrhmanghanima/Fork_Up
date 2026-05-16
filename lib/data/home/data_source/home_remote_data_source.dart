import 'package:fork_up/data/home/model/home_model.dart';

abstract class CategoriesRemoteDataSource {
  Future<HomeResponse> getHomeData();
}
