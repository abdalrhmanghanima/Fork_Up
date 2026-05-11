import 'package:fork_up/domain/home/entity/category_entity.dart';
class CategoryModel extends CategoryEntity {
  CategoryModel({
    required super.id,
    required super.name,
    required super.slug,
    required super.icon,
    required super.subCategory,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'],
      name: json['name'],
      slug: json['slug'],
      icon: json['icon'],
      subCategory: List<CategoryEntity>.from(
        (json['sub_category'] as List).map(
              (e) => CategoryModel.fromJson(e),
        ),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'slug': slug,
      'icon': icon,
      'sub_category': subCategory
          .map((e) => (e as CategoryModel).toJson())
          .toList(),
    };
  }
}