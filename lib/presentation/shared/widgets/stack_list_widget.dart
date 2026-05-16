import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fork_up/core/utils/app_icons.dart';
import 'package:fork_up/domain/home/entity/product_entity.dart';
import 'package:fork_up/presentation/cart/providers/cart_provider.dart';
import 'package:fork_up/presentation/home/widgets/product_card_widget.dart';
import 'package:fork_up/presentation/product_details/screen/product_details_screen.dart';
import 'package:fork_up/presentation/shared/provider/recently_viewed_provider.dart';
import 'package:fork_up/presentation/wish_list/provider/wish_list_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StackListWidget extends ConsumerWidget {
  final List<ProductEntity> products;
  final Axis scrollDirection;

  const StackListWidget({
    super.key,
    required this.products,
    required this.scrollDirection,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenWidth = MediaQuery.of(context).size.width;

    final cardWidth = screenWidth < 400
        ? screenWidth * 0.6
        : screenWidth < 700
        ? screenWidth * 0.4
        : screenWidth * 0.25;

    final cardHeight = screenWidth < 400 ? 220.0 : 240.0;
    final wishListState = ref.watch(wishlistProvider);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
      child: SizedBox(
        height: cardHeight,
        child: ListView.separated(
          scrollDirection: scrollDirection,
          itemCount: products.length,
          separatorBuilder: (_, __) => SizedBox(width: screenWidth * 0.03),
          itemBuilder: (context, index) {
            final product = products[index];
            final cartState = ref.watch(cartProvider);
            final isInCart =
                cartState.value?.any((e) => e.product.id == product.id) ??
                false;
            final isInWishlist = wishListState.any((e) => e.id == product.id);
            return SizedBox(
              width: cardWidth,
              child: ProductCard(
                image: product.thumbnail,
                name: product.name,
                price: product.priceBeforeDiscount,
                favourite: isInWishlist
                    ? SvgPicture.asset(AppIcons.likeFilled)
                    : SvgPicture.asset(AppIcons.like),
                add: isInCart
                    ? SvgPicture.asset(AppIcons.check, height: 34)
                    : SvgPicture.asset(AppIcons.add),

                onTap: () {
                  ref.read(recentlyViewedProvider.notifier).add(product);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ProductDetailsScreen(product: product),
                    ),
                  );
                },

                onAdd: () async {
                  final cartNotifier = ref.read(cartProvider.notifier);
                  final messenger = ScaffoldMessenger.of(context);

                  if (!cartNotifier.isInCart(product)) {
                    await cartNotifier.addToCart(product);

                    if (!context.mounted) return;

                    messenger.showSnackBar(
                      SnackBar(
                        content: Text('Product added to cart'),
                        backgroundColor: Colors.green,
                      ),
                    );
                  }
                },

                onLike: () async {
                  final isExist = ref
                      .read(wishlistProvider.notifier)
                      .isInWishlist(product);
                  final prefs = await SharedPreferences.getInstance();
                  if (!context.mounted) return;
                  final token = prefs.getString("token");

                  if (token == null || token.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Please login first'),
                        backgroundColor: Colors.red,
                      ),
                    );
                    return;
                  }
                  ref.read(wishlistProvider.notifier).toggle(product);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        isExist ? 'Removed from wishlist' : 'Added to wishlist',
                      ),
                      duration: Duration(seconds: 1),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
