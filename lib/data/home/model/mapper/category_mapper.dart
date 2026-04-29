import 'package:fork_up/data/home/model/category_model.dart';
import 'package:fork_up/domain/home/entity/category_entity.dart';

extension CategoryMapper on Category {
  CategoryEntity toEntity() {
    return CategoryEntity(
      id: id,
      name: name,
      slug: slug,
      icon: icon,
      subCategory: subCategory.map((e) => e.toEntity()).toList(),
    );
  }
}