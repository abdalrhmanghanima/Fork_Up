import 'package:fork_up/data/home/model/home_model.dart';
import 'package:fork_up/domain/home/entity/home_entity.dart';
import 'data_mapper.dart';

extension HomeMapper on HomeResponse {
  HomeEntity toEntity() {
    return HomeEntity(
      data: data.toEntity(),
      msg: msg,
      status: status,
      bestSellers: data.bestSellers.map((e) => e.toEntity()).toList(),
    );
  }
}
