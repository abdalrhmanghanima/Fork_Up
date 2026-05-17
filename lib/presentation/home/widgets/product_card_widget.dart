import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fork_up/core/utils/app_colors.dart';
import 'package:fork_up/core/utils/app_icons.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ProductCard extends StatelessWidget {
  final String image;
  final String name;
  final double price;
  final VoidCallback onTap;
  final VoidCallback? onAdd;
  final VoidCallback? onLike;
  final Widget favourite;
  final Widget add;

  const ProductCard({
    super.key,
    required this.image,
    required this.name,
    required this.price,
    required this.onTap,
    this.onAdd,
    this.onLike,
    required this.favourite,
    required this.add,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;

    return GestureDetector(
      onTap: onTap,

      child: Container(
        margin: const EdgeInsets.only(right: 12),

        width: width * 0.42,

        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),

                  child: SizedBox(
                    height: width * 0.28,
                    width: double.infinity,

                    child: CachedNetworkImage(
                      imageUrl: image,
                      fit: BoxFit.cover,

                      fadeInDuration: Duration.zero,
                      fadeOutDuration: Duration.zero,

                      placeholder: (context, url) => Container(
                        color: Colors.grey.shade200,
                      ),

                      errorWidget: (context, url, error) =>
                      const Icon(
                        Icons.image_not_supported,
                      ),
                    ),
                  ),
                ),

                Positioned(
                  right: 12,
                  top: 10,

                  child: GestureDetector(
                    onTap: onLike,
                    child: favourite,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 8),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),

              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Expanded(
                    child: Text(
                      name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,

                      style: TextStyle(
                        fontSize: width * 0.036,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),

                  const SizedBox(width: 4),

                  SvgPicture.asset(
                    AppIcons.more,
                    width: width * 0.055,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 6),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),

              child: Text(
                "\$ $price",

                style: TextStyle(
                  fontSize: width * 0.038,
                  fontWeight: FontWeight.bold,
                  color: AppColors.yellow,
                ),
              ),
            ),

            const SizedBox(height: 10),

            Align(
              alignment: Alignment.bottomRight,

              child: GestureDetector(
                onTap: onAdd,

                child: Padding(
                  padding: const EdgeInsets.only(
                    right: 6,
                    bottom: 6,
                  ),

                  child: add,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}