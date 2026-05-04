import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fork_up/core/di/di.dart';
import 'package:fork_up/core/utils/app_colors.dart';
import 'package:fork_up/core/utils/app_icons.dart';
import 'package:fork_up/core/utils/app_images.dart';
import 'package:fork_up/presentation/cart/cubit/cart_cubit.dart';
import 'package:fork_up/presentation/cart/cubit/search_cubit.dart';
import 'package:fork_up/presentation/cart/cubit/search_state.dart';
import 'package:fork_up/presentation/home/cubit/home_cubit.dart';
import 'package:fork_up/presentation/home/cubit/home_state.dart';
import 'package:fork_up/presentation/home/widgets/product_card_widget.dart';
import 'package:fork_up/presentation/product_details/cubit/product_cubit.dart';
import 'package:fork_up/presentation/product_details/screen/product_details_screen.dart';
import 'package:fork_up/presentation/shared/cubit/recently_viewed_cubit.dart';
import 'package:fork_up/presentation/shared/widgets/horizontal_list_widget.dart';
import 'package:fork_up/presentation/shared/widgets/product_grid_widget.dart';

class SearchViewWidget extends StatefulWidget {
  const SearchViewWidget({super.key});

  @override
  State<SearchViewWidget> createState() => _SearchViewWidgetState();
}

class _SearchViewWidgetState extends State<SearchViewWidget> {
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    context.read<SearchCubit>().initProducts();
  }
  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
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
                  context.read<SearchCubit>().search(value);
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
                child: BlocBuilder<SearchCubit, SearchState>(
                  builder: (context, state) {
                    if (state is SearchLoading) {
                      return Center(child: CircularProgressIndicator());
                    }
                    if (state is SearchError) {
                      return Center(child: Text("Error"));
                    }
                    if (state is SearchEmpty) {
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
                              BlocBuilder<HomeCubit, HomeState>(
                                builder: (context, state) {
                                  if (state is HomeLoading) {
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  }
                                  if (state is HomeSuccess) {
                                    final bestSellers = state.data.data.bestSellers;
                                    return Column(
                                      children: [
                                        ProductHorizontalList(
                                          scrollDirection: Axis.horizontal,
                                          products: bestSellers,
                                        ),
                                      ],
                                    );
                                  }
                                  return SizedBox.shrink();
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                    if (state is SearchLoaded) {
                      return ProductGridWidget(
                        items: state.results,

                        image: (product) => product.thumbnail,
                        name: (product) => product.name,
                        price: (product) => product.priceAfterDiscount,

                        onAdd: (product) {
                          context.read<CartCubit>().addToCart(product);
                        },

                        onTap: (product) {
                          context.read<RecentlyViewedCubit>().add(product);

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => BlocProvider(
                                create: (_) =>
                                sl<ProductDetailsCubit>()
                                  ..getProductDetails(product.slug),
                                child: ProductDetailsScreen(),
                              ),
                            ),
                          );
                        },
                      );
                    }
                    return SizedBox.shrink();
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
