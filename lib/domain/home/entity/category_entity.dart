class CategoryEntity {
  final int id;
  final String name;
  final String slug;
  final String icon;
  final List<CategoryEntity> subCategory;

  CategoryEntity({
    required this.id,
    required this.name,
    required this.slug,
    required this.icon,
    required this.subCategory,
  });
}