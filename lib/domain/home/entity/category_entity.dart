class CategoriesResponseEntity {
  final List<CategoryEntity> data;
  final String msg;
  final int status;

  CategoriesResponseEntity({
    required this.data,
    required this.msg,
    required this.status,
  });
}

class CategoryEntity {
  final int id;
  final String name;
  final String slug;
  final String icon;
  final List<CategoryEntity> subCategory;

  const CategoryEntity({
    required this.id,
    required this.name,
    required this.slug,
    required this.icon,
    required this.subCategory,
  });
}
