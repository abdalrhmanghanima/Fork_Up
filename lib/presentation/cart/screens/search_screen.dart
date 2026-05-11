import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fork_up/core/utils/app_colors.dart';
import 'package:fork_up/core/utils/app_icons.dart';
import 'package:fork_up/core/utils/app_images.dart';
import 'package:fork_up/presentation/cart/providers/cart_provider.dart';
import 'package:fork_up/presentation/cart/providers/search_provider.dart';
import 'package:fork_up/presentation/product_details/screen/product_details_screen.dart';
import 'package:fork_up/presentation/shared/provider/recently_viewed_provider.dart';
import 'package:fork_up/presentation/shared/widgets/stack_list_widget.dart';
import 'package:fork_up/presentation/shared/widgets/product_grid_widget.dart';
import 'package:fork_up/presentation/wish_list/provider/wish_list_provider.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  Timer? _debounce;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final searchState = ref.watch(searchProvider);
    final cartState = ref.watch(cartProvider);
    final recentlyViewedState = ref.watch(recentlyViewedProvider);
    final wishListState = ref.watch(wishlistProvider);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: Padding(
          padding: EdgeInsets.only(left: width * 0.04),
          child: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: SvgPicture.asset(AppIcons.back),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 24,right: 24,bottom: 24,top: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Find Your\nFavorite Food",
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 16),
            TextField(
              onChanged: (value) {
                if (_debounce?.isActive ?? false) _debounce!.cancel();

                _debounce = Timer(const Duration(milliseconds: 300), () {
                  ref.read(searchProvider.notifier).search(value);
                });
              },
              style: TextStyle(
                color: Colors.black,
                fontSize: 17,
                fontWeight: FontWeight.w500,
              ),
              decoration: InputDecoration(
                hintText: 'Search...',
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.grey, width: 2),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.grey, width: 2),
                ),
                prefixIcon: Padding(
                  padding: const EdgeInsets.only(left: 14, right: 8),
                  child: SvgPicture.asset(AppIcons.searchDark),
                ),
                suffixIcon: Padding(
                  padding: const EdgeInsets.only(right: 14),
                  child: SvgPicture.asset(AppIcons.icon),
                ),
                prefixIconConstraints: BoxConstraints(
                  minWidth: 25,
                  minHeight: 25,
                ),

                suffixIconConstraints: BoxConstraints(
                  minWidth: 25,
                  minHeight: 25,
                ),
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: SingleChildScrollView(
                child: searchState.when(
                    data: (data) {
                      if(data.isEmpty){
                          return Padding(
                            padding: const EdgeInsets.only(top: 24,),
                            child: Center(
                              child: Column(
                                children: [
                                  Image.asset(AppImages.illustration),
                                  SizedBox(height: 20),
                                  Text(
                                    "We couldn't find any result!",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  SizedBox(height: 12),
                                  Text(
                                    "The product you are trying to search for is not\ncurrently available, We selected some other\noptions that you may like",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.lightGray,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20,bottom: 12),
                                    child: Row(
                                      children: [
                                        Text(
                                          'Recently Viewed',
                                          style: TextStyle(
                                            fontSize: width * 0.04,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  recentlyViewedState.when(
                                    data: (data) {
                                      if(data.isEmpty){
                                        return SizedBox();
                                      }
                                      return StackListWidget(
                                        scrollDirection: Axis.horizontal,
                                        products: data,
                                      );
                                    },
                                    error: (error, stack) {
                                      return Center(
                                        child: Text(error.toString()),
                                      );
                                    },
                                    loading: () {
                                      return const Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    },

                                  ),
                                ],
                              ),
                            ),
                          );
                        }
                      return ProductGridWidget(
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
                        add: (product) {
                          final isInCart =
                              cartState.value?.any(
                                    (e) => e.product.id == product.id,
                              ) ?? false;
                          return isInCart
                              ? SvgPicture.asset(AppIcons.check,height: 34,)
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
                      );
                    },
                  error: (error, stack) {
                    return Center(
                      child: Text(error.toString()),
                    );
                  },
                  loading: () {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                )
              ),
            ),
          ],
        ),
      ),
    );
  }
}
