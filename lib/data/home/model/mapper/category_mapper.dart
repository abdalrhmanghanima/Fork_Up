import 'package:fork_up/data/categories/model/categories_response_model.dart';
import 'package:fork_up/data/home/model/category_model.dart';
import 'package:fork_up/domain/home/entity/category_entity.dart';

extension CategoryMapper on CategoryModel {
  CategoryEntity toEntity() {
    return CategoryEntity(
      id: id,
      name: name,
      slug: slug,
      icon: icon,
      subCategory: subCategory,
    );
  }
}

extension CategoriesResponseMapper
on CategoriesResponseModel {

  CategoriesResponseEntity toEntity() {

    return CategoriesResponseEntity(
      data: data,
      msg: msg,
      status: status,
    );
  }
}