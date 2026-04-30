import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fork_up/core/utils/app_colors.dart';
import 'package:fork_up/core/utils/app_icons.dart';

class ProductCard extends StatelessWidget {
  final String image;
  final String name;
  final double price;
  final VoidCallback onTap;
  final VoidCallback? onAdd;
  final VoidCallback? onLike;

  const ProductCard({
    super.key,
    required this.image,
    required this.name,
    required this.price,
    required this.onTap,
    this.onAdd,
    this.onLike,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(right: 12),
        width: 152,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: 120,
                  width: 147,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                      image: NetworkImage(image),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  right: 16,
                  top: 11,
                  child: GestureDetector(
                    onTap: onLike,
                    child: SvgPicture.asset(AppIcons.like),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 8),

            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(width: 4),
                SvgPicture.asset(AppIcons.more, width: 16),
              ],
            ),

            const SizedBox(height: 6),

            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "\$ $price",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.yellow,
                ),
              ),
            ),

            const Spacer(),

            Align(
              alignment: Alignment.bottomRight,
              child: GestureDetector(
                onTap: onAdd,
                child: Padding(
                  padding: const EdgeInsets.only(right: 6),
                  child: SvgPicture.asset(AppIcons.add),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}