import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fork_up/core/utils/app_colors.dart';
import 'package:fork_up/core/utils/app_icons.dart';
import 'package:fork_up/domain/categories/arguments/categories_details_arguments.dart';
import 'package:fork_up/presentation/cart/providers/cart_provider.dart';
import 'package:fork_up/presentation/product_details/screen/product_details_screen.dart';
import 'package:fork_up/presentation/shared/provider/recently_viewed_provider.dart';
import 'package:fork_up/presentation/shared/widgets/product_grid_widget.dart';
import 'package:fork_up/presentation/whole_sale/provider/whole_sale_provider.dart';
import 'package:fork_up/presentation/wish_list/provider/wish_list_provider.dart';

class CategoriesDetailsScreen extends ConsumerStatefulWidget {
  final CategoryDetailsArgs arguments;

  const CategoriesDetailsScreen({super.key, required this.arguments});

  @override
  ConsumerState<CategoriesDetailsScreen> createState() =>
      _CategoriesDetailsScreenState();
}

class _CategoriesDetailsScreenState
    extends ConsumerState<CategoriesDetailsScreen> {
  late int currentCategoryId;
  int selectedIndex = 0;
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {

      final notifier =
      ref.read(wholeSaleProvider.notifier);

      if (widget.arguments.subCategories != null &&
          widget.arguments.subCategories!.isNotEmpty) {

        notifier.getProducts(
          subCategoryId:
          widget.arguments.subCategories![0].id,
        );

      } else {

        notifier.getProducts(
          categoryId: widget.arguments.id,
        );
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final wholeSaleState = ref.watch(wholeSaleProvider);
    final wishListState = ref.watch(wishlistProvider);
    final cartState = ref.watch(cartProvider);
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: EdgeInsets.only(left: width * 0.04),
          child: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: SvgPicture.asset(AppIcons.back),
          ),
        ),
        title: Text(widget.arguments.name),
        centerTitle: true,
        actions: [
          SvgPicture.asset(AppIcons.sort),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SvgPicture.asset(AppIcons.filter),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left:24,right: 24,bottom: 24),
          child: Column(
            children: [
              SizedBox(
                height: 50,

                width: double.infinity,

                child: ListView.builder(
                  scrollDirection: Axis.horizontal,

                  itemCount: widget.arguments.subCategories?.length ?? 0,

                  itemBuilder: (context, index) {
                    final subCategory = widget.arguments.subCategories![index];

                    final isSelected = selectedIndex == index;

                    return GestureDetector(
                      onTap: () {

                        setState(() {
                          selectedIndex = index;
                        });

                        ref.read(wholeSaleProvider.notifier)
                            .getProducts(
                          subCategoryId: subCategory.id,
                        );
                      },

                      child: Container(
                        alignment: Alignment.center,

                        padding: const EdgeInsets.symmetric(horizontal: 20),

                        margin: const EdgeInsets.only(right: 8),

                        decoration: BoxDecoration(
                          color: isSelected ? AppColors.yellow : Colors.white,

                          borderRadius: BorderRadius.circular(25),

                          border: Border.all(color: AppColors.lightGray),
                        ),

                        child: Text(
                          subCategory.name,

                          textAlign: TextAlign.center,

                          style: TextStyle(
                            color: isSelected ? Colors.white : Colors.black,

                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 20),
              wholeSaleState.when(
                data: (data) {

                  return ProductGridWidget(
                    items: data,

                    image: (item) => item.thumbnail,

                    name: (item) => item.name,

                    price: (item) => item.priceAfterDiscount,

                    favourite: (item) {
                      final isInWishlist = wishListState.any(
                        (e) => e.id == item.id,
                      );
                      return isInWishlist
                          ? SvgPicture.asset(AppIcons.likeFilled)
                          : SvgPicture.asset(AppIcons.like);
                    },

                    add: (item) {
                      final isInCart =
                          cartState.value?.any((e) => e.product.id == item.id) ??
                          false;
                      return isInCart
                          ? SvgPicture.asset(AppIcons.check, height: 34)
                          : SvgPicture.asset(AppIcons.add);
                    },
                    onAdd: (item) async {
                      final cartNotifier = ref.read(cartProvider.notifier);
                      final messenger = ScaffoldMessenger.of(context);

                      if (!cartNotifier.isInCart(item)) {
                        await cartNotifier.addToCart(item);

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
                      ref.read(recentlyViewedProvider.notifier).add(item);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ProductDetailsScreen(product: item),
                        ),
                      );
                    },
                    onLike: (item) {
                      final isExist = ref
                          .read(wishlistProvider.notifier)
                          .isInWishlist(item);
                      ref.read(wishlistProvider.notifier).toggle(item);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            isExist ? 'Removed from wishlist' : 'Added to wishlist',
                          ),
                          duration: Duration(seconds: 1),
                        ),
                      );
                    },
                  );
                },

                loading: () {
                  return const Center(child: CircularProgressIndicator());
                },

                error: (error, stack) {
                  return Center(child: Text(error.toString()));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
