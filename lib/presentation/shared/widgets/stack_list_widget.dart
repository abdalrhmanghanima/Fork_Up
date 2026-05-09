import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fork_up/core/di/di.dart';
import 'package:fork_up/core/utils/app_icons.dart';
import 'package:fork_up/domain/home/entity/product_entity.dart';
import 'package:fork_up/presentation/cart/cubit/cart_cubit.dart';
import 'package:fork_up/presentation/home/widgets/product_card_widget.dart';
import 'package:fork_up/presentation/product_details/cubit/product_cubit.dart';
import 'package:fork_up/presentation/product_details/screen/product_details_screen.dart';
import 'package:fork_up/presentation/shared/cubit/recently_viewed_cubit.dart';
import 'package:fork_up/presentation/wish_list/cubit/wish_list_cubit.dart';

class StackListWidget extends StatelessWidget {
  final List<ProductEntity> products;
  final Axis scrollDirection;

  const StackListWidget({
    super.key,
    required this.products,
    required this.scrollDirection,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    final cardWidth = screenWidth < 400
        ? screenWidth * 0.6
        : screenWidth < 700
        ? screenWidth * 0.4
        : screenWidth * 0.25;

    final cardHeight = screenWidth < 400 ? 220.0 : 240.0;

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

            return SizedBox(
              width: cardWidth,
              child: ProductCard(
                image: product.thumbnail,
                name: product.name,
                price: product.priceBeforeDiscount,
                favourite: context.watch<WishlistCubit>().isInWishlist(product)
                    ? SvgPicture.asset(AppIcons.likeFilled)
                    : SvgPicture.asset(AppIcons.like),
                add: context.watch<CartCubit>().isInCart(product)
                    ? SvgPicture.asset(AppIcons.check,height: 34,)
                    : SvgPicture.asset(AppIcons.add),

                onTap: () {
                  context.read<RecentlyViewedCubit>().add(product);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => BlocProvider(
                        create: (_) =>
                            sl<ProductDetailsCubit>()
                              ..getProductDetails(product.slug),
                        child: const ProductDetailsScreen(),
                      ),
                    ),
                  );
                },

                onAdd: () async {
                  final cartCubit = context.read<CartCubit>();
                  final messenger = ScaffoldMessenger.of(context);

                  if (!cartCubit.isInCart(product)) {

                    await cartCubit.addToCart(product);

                    if (!context.mounted) return;

                    messenger.showSnackBar(
                      SnackBar(
                        content: Text('Product added to cart'),
                        backgroundColor: Colors.green,
                        duration: Duration(seconds: 2),
                      ),
                    );
                  }
                },

                onLike: () {
                  final isExist = context
                      .read<WishlistCubit>()
                      .isInWishlist(product);
                  context.read<WishlistCubit>().toggle(product);
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          isExist
                              ? 'Removed from wishlist'
                              : 'Added to wishlist',
                        ),
                        duration: Duration(seconds: 1),
                      )
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
