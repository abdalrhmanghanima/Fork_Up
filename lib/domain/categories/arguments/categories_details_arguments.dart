import 'package:fork_up/domain/home/entity/category_entity.dart';
class CategoryDetailsArgs {
  final int id;
  final String name;
  final List<CategoryEntity>? subCategories;


  CategoryDetailsArgs({
    required this.id,
    required this.name,
     this.subCategories,
  });
}