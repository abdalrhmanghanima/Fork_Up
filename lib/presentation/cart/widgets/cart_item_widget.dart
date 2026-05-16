import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fork_up/core/utils/app_colors.dart';
import 'package:fork_up/core/utils/app_icons.dart';
import 'package:fork_up/domain/cart/entity/cart_entity.dart';
import 'package:fork_up/presentation/cart/providers/cart_provider.dart';

class CartItemWidget extends ConsumerWidget {
  final CartEntity item;

  const CartItemWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final product = item.product;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              product.thumbnail,
              width: 90,
              height: 90,
              fit: BoxFit.cover,
            ),
          ),

          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),

                const SizedBox(height: 6),
                Text(
                  "\$ ${product.priceAfterDiscount}",
                  style: TextStyle(
                    color: AppColors.yellow,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 10),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        ref
                            .read(cartProvider.notifier)
                            .decreaseQuantity(item.product);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                        child: SvgPicture.asset(
                          AppIcons.minusRounded,
                          height: 20,
                          width: 20,
                        ),
                      ),
                    ),

                    const SizedBox(width: 12),
                    Text(
                      item.quantity.toString(),
                      style: const TextStyle(fontSize: 16),
                    ),

                    const SizedBox(width: 12),
                    GestureDetector(
                      onTap: () {
                        ref
                            .read(cartProvider.notifier)
                            .increaseQuantity(item.product);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                        child: SvgPicture.asset(
                          AppIcons.plusRounded,
                          height: 20,
                          width: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          IconButton(
            onPressed: () async {
              await ref.read(cartProvider.notifier).remove(item.product);

              if (!context.mounted) return;

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Product removed from cart'),
                  backgroundColor: Colors.red,
                  duration: Duration(seconds: 2),
                ),
              );
            },
            icon: SvgPicture.asset(AppIcons.delete),
          ),
        ],
      ),
    );
  }
}
