import 'package:fork_up/data/home/model/data_model.dart';
import 'package:fork_up/data/home/model/product_model.dart';

class HomeResponse {
  final Data data;
  final String msg;
  final int status;
  final List<Product> bestSellers;

  HomeResponse({
    required this.data,
    required this.msg,
    required this.status,
    required this.bestSellers
  });

  factory HomeResponse.fromJson(Map<String, dynamic> json) {
    return HomeResponse(
      data: Data.fromJson(json['data']),
      msg: json['msg'],
      status: json['status'],
      bestSellers: (json['best_sellers'] as List? ?? [])
          .map((e) => Product.fromJson(e))
          .toList(),
    );
  }
}