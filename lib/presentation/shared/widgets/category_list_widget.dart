import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fork_up/core/utils/app_colors.dart';
import 'package:fork_up/domain/home/entity/category_entity.dart';

class CategoryListWidget extends StatelessWidget {
  final List<CategoryEntity> categories;
  final void Function(dynamic category)? onTap;

  const CategoryListWidget({super.key, required this.categories, this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 170,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];

          return GestureDetector(
            onTap: () => onTap?.call(category),
            child: Container(
              width: 140,
              margin: const EdgeInsets.only(right: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(16),
                    ),
                    child: SizedBox(
                      height: 120,
                      width: double.infinity,
                      child: CachedNetworkImage(
                        imageUrl: category.icon,
                        fit: BoxFit.cover,

                        fadeInDuration: Duration.zero,
                        fadeOutDuration: Duration.zero,

                        placeholder: (context, url) =>
                            Container(color: Colors.grey.shade200),

                        errorWidget: (context, url, error) =>
                            const Icon(Icons.image_not_supported),
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  Padding(
                    padding: const EdgeInsets.only(left: 25),
                    child: Text(
                      category.name,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.blue,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
