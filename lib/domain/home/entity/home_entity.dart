import 'package:fork_up/domain/home/entity/data_entity.dart';

class HomeEntity {
  final DataEntity data;
  final String msg;
  final int status;

  HomeEntity({
    required this.data,
    required this.msg,
    required this.status,
  });
}