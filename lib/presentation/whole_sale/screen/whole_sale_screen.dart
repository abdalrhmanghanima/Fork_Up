import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fork_up/core/utils/app_icons.dart';
import 'package:fork_up/domain/categories/arguments/categories_details_arguments.dart';
import 'package:fork_up/presentation/cart/providers/cart_provider.dart';
import 'package:fork_up/presentation/categories/provider/categories_provider.dart';
import 'package:fork_up/presentation/categories/screen/categories_details_screen.dart';
import 'package:fork_up/presentation/product_details/screen/product_details_screen.dart';
import 'package:fork_up/presentation/shared/provider/recently_viewed_provider.dart';
import 'package:fork_up/presentation/shared/widgets/category_list_widget.dart';
import 'package:fork_up/presentation/shared/widgets/product_grid_widget.dart';
import 'package:fork_up/presentation/whole_sale/provider/whole_sale_provider.dart';
import 'package:fork_up/presentation/wish_list/provider/wish_list_provider.dart';

class WholeSaleScreen extends ConsumerStatefulWidget {
  const WholeSaleScreen({super.key});

  @override
  ConsumerState<WholeSaleScreen> createState() => _WholeSaleScreenState();
}

class _WholeSaleScreenState extends ConsumerState<WholeSaleScreen> {
  final controller = ScrollController();
  @override
  void initState() {
    super.initState();
    Future.microtask(() {

      ref
          .read(wholeSaleProvider.notifier)
          .getProducts();
    });
    controller.addListener(() {
      if (controller.position.pixels >=
          controller.position.maxScrollExtent - 200) {
        ref
            .read(wholeSaleProvider.notifier)
            .loadMore();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final categoriesState = ref.watch(categoriesProvider);
    final wholeSaleState = ref.watch(wholeSaleProvider);
    final cartState = ref.watch(cartProvider);
    final wishListState = ref.watch(wishlistProvider);
    return Scaffold(
        appBar: AppBar(title: const Text("WholeSale"), centerTitle: true),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Categories',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                categoriesState.when(
                    data: (data) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 13, bottom: 13),
                        child: CategoryListWidget(
                          categories: data.data,
                          onTap: (category) {
                            Navigator.push(context,
                              MaterialPageRoute(builder: (context) => CategoriesDetailsScreen(
                                arguments: CategoryDetailsArgs(
                                    id: category.id,
                                    name: category.name,
                                    subCategories: category.subCategory
                                ),
                              ),),);
                          },
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
                ),
                Row(
                  children: [
                    Text(
                      'Products',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    Spacer(),
                    SvgPicture.asset(AppIcons.sort),
                    SizedBox(width: 7),
                    SvgPicture.asset(AppIcons.filter),
                  ],
                ),
                SizedBox(height: 8),
                wholeSaleState.when(
                    data: (data) {
                      return ProductGridWidget(
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
                        controller: controller,
                        items: data,
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
              ],
            ),
          ),
        ),
      );
  }
}
