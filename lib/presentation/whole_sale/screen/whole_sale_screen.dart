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
import 'package:fork_up/presentation/shared/widgets/category_list_widget.dart';
import 'package:fork_up/presentation/shared/widgets/product_grid_widget.dart';
import 'package:fork_up/presentation/whole_sale/cubit/whole_sale_cubit.dart';
import 'package:fork_up/presentation/whole_sale/cubit/whole_sale_state.dart';

class WholeSaleScreen extends StatefulWidget {
  const WholeSaleScreen({super.key});

  @override
  State<WholeSaleScreen> createState() => _WholeSaleScreenState();
}

class _WholeSaleScreenState extends State<WholeSaleScreen> {
  final controller = ScrollController();
  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      if (controller.position.pixels >=
          controller.position.maxScrollExtent - 200) {
        context.read<WholeSaleCubit>().loadMore();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<WholeSaleCubit>()..getProducts(),
      child: Scaffold(
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
                BlocBuilder<HomeCubit, HomeState>(
                  builder: (context, state) {
                    if (state is HomeLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (state is HomeSuccess) {
                      final data = state.data;
                      return Padding(
                        padding: const EdgeInsets.only(top: 13, bottom: 13),
                        child: CategoryListWidget(
                          categories: data.data.categories,
                          onTap: (category) {},
                        ),
                      );
                    }
                    return SizedBox.shrink();
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
                BlocBuilder<WholeSaleCubit, WholeSaleState>(
                  builder: (context, state) {
                    if (state is WholeSaleLoading) {
                      return Center(child: CircularProgressIndicator());
                    }
                    if (state is WholeSaleError) {
                      return Center(child: Text("Error"));
                    }
                    if (state is WholeSaleSuccess) {
                      return ProductGridWidget(
                        controller: controller,
                        items: state.products,
                        image: (product) => product.thumbnail,
                        name: (product) => product.name,
                        price: (product) => product.priceAfterDiscount,
                        onAdd: (item) async {
                          await context.read<CartCubit>().addToCart(item);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Product added to cart'),
                              backgroundColor: Colors.green,
                              duration: Duration(seconds: 2),
                            ),
                          );
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
                      );
                    }
                    return SizedBox.shrink();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
