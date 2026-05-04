import 'package:fork_up/domain/home/entity/data_entity.dart';
import 'package:fork_up/domain/home/entity/product_entity.dart';

class HomeEntity {
  final DataEntity data;
  final String msg;
  final int status;
  final List<ProductEntity> bestSellers;

  HomeEntity({
    required this.data,
    required this.msg,
    required this.status,
    required this.bestSellers
  });
}