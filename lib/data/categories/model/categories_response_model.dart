import 'package:fork_up/data/home/model/category_model.dart';
import 'package:fork_up/domain/home/entity/category_entity.dart';

class CategoriesResponseModel extends CategoriesResponseEntity {
  CategoriesResponseModel({
    required super.data,
    required super.msg,
    required super.status,
  });

  factory CategoriesResponseModel.fromJson(Map<String, dynamic> json) {
    return CategoriesResponseModel(
      data: List<CategoryEntity>.from(
        (json['data'] as List).map((e) => CategoryModel.fromJson(e)),
      ),

      msg: json['msg'],

      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data.map((e) => (e as CategoryModel).toJson()).toList(),

      'msg': msg,

      'status': status,
    };
  }
}
