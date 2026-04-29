import 'package:fork_up/data/home/model/data_model.dart';

class HomeResponse {
  final Data data;
  final String msg;
  final int status;

  HomeResponse({
    required this.data,
    required this.msg,
    required this.status,
  });

  factory HomeResponse.fromJson(Map<String, dynamic> json) {
    return HomeResponse(
      data: Data.fromJson(json['data']),
      msg: json['msg'],
      status: json['status'],
    );
  }
}