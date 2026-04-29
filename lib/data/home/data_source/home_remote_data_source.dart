import 'package:fork_up/data/home/model/home_model.dart';

abstract class HomeRemoteDataSource {
  Future<HomeResponse> getHomeData();
}