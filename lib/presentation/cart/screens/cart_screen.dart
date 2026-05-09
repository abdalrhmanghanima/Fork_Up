import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fork_up/core/utils/app_colors.dart';
import 'package:fork_up/core/utils/app_icons.dart';
import 'package:fork_up/core/utils/app_images.dart';
import 'package:fork_up/presentation/cart/cubit/cart_cubit.dart';
import 'package:fork_up/presentation/cart/cubit/cart_state.dart';
import 'package:fork_up/presentation/cart/screens/search_screen.dart';
import 'package:fork_up/presentation/cart/widgets/cart_item_widget.dart';
import 'package:fork_up/presentation/home/cubit/home_cubit.dart';
import 'package:fork_up/presentation/home/cubit/home_state.dart';
import 'package:fork_up/presentation/shared/widgets/stack_list_widget.dart';
import 'package:fork_up/presentation/shared/cubit/recently_viewed_cubit.dart';
import 'package:fork_up/presentation/shared/cubit/recently_viewed_state.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    super.initState();
    context.read<CartCubit>().getCart();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: EdgeInsets.only(left: width * 0.04),
          child: GestureDetector(child: SvgPicture.asset(AppIcons.back)),
        ),
        title: const Text("My Cart"),
        centerTitle: true,
      ),
      body: BlocBuilder<CartCubit, CartState>(
        builder: (context, state) {
          if (state is CartLoading) {
            return Center(child: CircularProgressIndicator());
          }
          if (state is CartLoaded) {
            if (state.items.isEmpty) {
              return Padding(
                padding: const EdgeInsets.only(top: 12, right: 27, left: 27),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(AppImages.illustration),
                      SizedBox(height: 20),
                      Text(
                        "Ouch! Hungry",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: 12),
                      Text(
                        "Seems like you have not ordered\n any food yet",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: AppColors.lightGray,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 25),
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.blue,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40),
                          ),
                          padding: EdgeInsets.symmetric(
                            vertical: 15,
                            horizontal: 145,
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SearchScreen(),
                            ),
                          );
                        },
                        label: Text(
                          "Find Foods",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Best seller',
                            style: TextStyle(
                              fontSize: width * 0.04,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            'See All',
                            style: TextStyle(
                              fontSize: width * 0.04,
                              color: AppColors.yellow,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 12),
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
                                StackListWidget(
                                  scrollDirection: Axis.horizontal,
                                  products: bestSellers,
                                ),
                              ],
                            );
                          }
                          return SizedBox.shrink();
                        },
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'recently viewed',
                            style: TextStyle(
                              fontSize: width * 0.04,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            'See All',
                            style: TextStyle(
                              fontSize: width * 0.04,
                              color: AppColors.yellow,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 12),
                      BlocBuilder<RecentlyViewedCubit, RecentlyViewedState>(
                        builder: (context, recentState) {
                          if (recentState.products.isEmpty) {
                            return SizedBox();
                          }
                          return StackListWidget(
                            scrollDirection: Axis.horizontal,
                            products: recentState.products,
                          );
                        },
                      ),
                    ],
                  ),
                ),
              );
            }
            return SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 24,
                      right: 24,
                      top: 16,
                      bottom: 24,
                    ),
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: state.items.length,
                      itemBuilder: (context, index) {
                        final item = state.items[index];
                        return CartItemWidget(item: item);
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 35),
                    child: Row(
                      children: [
                        Text(
                          'Recently Viewed',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 16,
                      left: 24,
                      right: 24,
                      bottom: 19,
                    ),
                    child:
                        BlocBuilder<RecentlyViewedCubit, RecentlyViewedState>(
                          builder: (context, recentState) {
                            if (recentState.products.isEmpty) {
                              return SizedBox();
                            }
                            return StackListWidget(
                              scrollDirection: Axis.horizontal,
                              products: recentState.products,
                            );
                          },
                        ),
                  ),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.blue,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40),
                      ),
                      padding: EdgeInsets.symmetric(
                        vertical: 15,
                        horizontal: 145,
                      ),
                    ),
                    onPressed: () {},
                    label: Text(
                      "Checkout",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
          if (state is CartError) {
            return Center(child: Text(state.message));
          }
          return SizedBox.shrink();
        },
      ),
    );
  }
}
