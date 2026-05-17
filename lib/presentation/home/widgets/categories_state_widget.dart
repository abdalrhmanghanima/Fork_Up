import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fork_up/core/utils/app_colors.dart';
import 'package:fork_up/domain/categories/arguments/categories_details_arguments.dart';
import 'package:fork_up/presentation/categories/provider/categories_provider.dart';
import 'package:fork_up/presentation/categories/screen/categories_details_screen.dart';
import 'package:fork_up/presentation/categories/widget/categories_shimmer_widget.dart';

class CategoriesStateWidget extends ConsumerWidget {
  const CategoriesStateWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categoriesState = ref.watch(categoriesProvider);
    return categoriesState.when(
      data: (data) {
        return Padding(
          padding: const EdgeInsets.only(left: 12),
          child: SizedBox(
            height: 170,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: data.data.length,
              itemBuilder: (context, index) {
                final category = data.data[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            CategoriesDetailsScreen(
                              arguments: CategoryDetailsArgs(
                                id: category.id,
                                name: category.name,
                                subCategories:
                                category.subCategory,
                              ),
                            ),
                      ),
                    );
                  },
                  child: Container(
                    width: 140,
                    margin: EdgeInsets.only(right: 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.vertical(
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
                                  Container(
                                    color: Colors.grey.shade200,
                                  ),

                              errorWidget:
                                  (context, url, error) =>
                                  Icon(
                                    Icons.image_not_supported,
                                  ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 12),

                        Padding(
                          padding: const EdgeInsets.only(
                            left: 25,
                          ),
                          child: Text(
                            category.name,
                            style: TextStyle(
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
          ),
        );
      },
      loading: () {
        return CategoriesShimmerWidget();
      },

      error: (error, stack) {
        return Center(child: Text(error.toString()));
      },
    );
  }
}
