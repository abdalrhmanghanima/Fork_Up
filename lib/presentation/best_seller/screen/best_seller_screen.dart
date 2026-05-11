import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fork_up/core/utils/app_icons.dart';
import 'package:fork_up/presentation/cart/providers/cart_provider.dart';
import 'package:fork_up/presentation/home/providers/home_provider.dart';
import 'package:fork_up/presentation/product_details/screen/product_details_screen.dart';
import 'package:fork_up/presentation/shared/provider/recently_viewed_provider.dart';
import 'package:fork_up/presentation/shared/widgets/product_grid_widget.dart';
import 'package:fork_up/presentation/wish_list/provider/wish_list_provider.dart';
class BestSellerScreen extends ConsumerWidget {
  const BestSellerScreen({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final size = MediaQuery
        .of(context)
        .size;
    final width = size.width;
    final homeState = ref.watch(homeProvider);
    final cartState= ref.watch(cartProvider);
    final wishListState = ref.watch(wishlistProvider);

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
        body: homeState.when(
          data: (data) {
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
                      favourite: (product) {
                        final isInWishlist =
                        wishListState.any(
                              (e) => e.id == product.id,
                        );
                        return isInWishlist?
                        SvgPicture.asset(AppIcons.likeFilled)
                            : SvgPicture.asset(AppIcons.like);

                      },
                      add: (product){
                        final isInCart =
                            cartState.value?.any(
                                  (e) => e.product.id == product.id,
                            ) ?? false;
                         return isInCart
                            ? SvgPicture.asset(AppIcons.check, height: 34,)
                            : SvgPicture.asset(AppIcons.add);
                      },
                      onAdd: (product) async {
                        final cartNotifier = ref.read(cartProvider.notifier);
                        final messenger = ScaffoldMessenger.of(context);

                        if (!cartNotifier.isInCart(product)) {
                          await cartNotifier.addToCart(product);

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
                      onTap: (product) {
                        ref.read(recentlyViewedProvider.notifier).add(product);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ProductDetailsScreen(product: product,),
                          ),
                        );
                      },
                      onLike: (product) {
                        final isExist = ref
                            .read(wishlistProvider.notifier)
                            .isInWishlist(product);
                        ref.read(wishlistProvider.notifier).toggle(product);
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
          },
          loading: () {
            return const Center(
              child: CircularProgressIndicator(),
            );
          },

          error: (error, stack) {
            return Center(
              child: Text(error.toString()),
            );
          },
        )
    );
  }
  }
