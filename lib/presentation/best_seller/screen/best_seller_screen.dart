import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fork_up/core/di/di.dart';
import 'package:fork_up/core/utils/app_icons.dart';
import 'package:fork_up/presentation/cart/cubit/cart_cubit.dart';
import 'package:fork_up/presentation/home/cubit/home_cubit.dart';
import 'package:fork_up/presentation/home/cubit/home_state.dart';
import 'package:fork_up/presentation/product_details/cubit/product_cubit.dart';
import 'package:fork_up/presentation/product_details/screen/product_details_screen.dart';
import 'package:fork_up/presentation/shared/cubit/recently_viewed_cubit.dart';
import 'package:fork_up/presentation/shared/widgets/product_grid_widget.dart';
import 'package:fork_up/presentation/wish_list/cubit/wish_list_cubit.dart';
class BestSellerScreen extends StatelessWidget {
  const BestSellerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: EdgeInsets.only(left: width * 0.04),
          child: GestureDetector(
            child: SvgPicture.asset(AppIcons.back),
            onTap: () => Navigator.pop(context),
          ),
        ),
        title: const Text("Top Selling Products"),
        centerTitle: true,
      ),
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          if (state is HomeLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is HomeSuccess) {
            final data = state.data;
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    ProductGridWidget(
                      items: data.data.bestSellers,
                      image: (product) => product.thumbnail,
                      name: (product) => product.name,
                      price: (product) => product.priceAfterDiscount,
                      favourite: (product) => context.watch<WishlistCubit>().isInWishlist(product)?
                      SvgPicture.asset(AppIcons.likeFilled)
                          : SvgPicture.asset(AppIcons.like),
                      add: (product) =>
                      context.watch<CartCubit>().isInCart(product)
                          ? SvgPicture.asset(AppIcons.check,height: 34,)
                          : SvgPicture.asset(AppIcons.add),
                      onAdd: (product) async {
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
                      onTap: (item) {
                        context.read<RecentlyViewedCubit>().add(item);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => BlocProvider(
                              create: (_) =>
                              sl<ProductDetailsCubit>()
                                ..getProductDetails(item.slug),
                              child: const ProductDetailsScreen(),
                            ),
                          ),
                        );
                      },
                      onLike: (product) {
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
                  ],
                ),
              ),
            );
          }
          return SizedBox.shrink();
        },
      ),
    );
  }
}
