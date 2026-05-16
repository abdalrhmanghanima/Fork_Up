import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fork_up/core/utils/app_colors.dart';
import 'package:fork_up/core/utils/app_icons.dart';
import 'package:fork_up/domain/home/entity/product_entity.dart';
import 'package:fork_up/domain/product_details/entity/mapper/product_details_mapper.dart';
import 'package:fork_up/presentation/cart/providers/cart_provider.dart';
import 'package:fork_up/presentation/product_details/provider/product_details_provider.dart';
import 'package:fork_up/presentation/product_details/widgets/product_details_shimmer.dart';
import 'package:fork_up/presentation/shared/provider/recently_viewed_provider.dart';
import 'package:fork_up/presentation/shared/widgets/stack_list_widget.dart';
import 'package:fork_up/presentation/product_details/widgets/product_image_slider.dart';
import 'package:fork_up/presentation/product_details/widgets/small_product_card.dart';
import 'package:shimmer/shimmer.dart';

class ProductDetailsScreen extends ConsumerStatefulWidget {
  final ProductEntity product;

  const ProductDetailsScreen({super.key, required this.product});

  @override
  ConsumerState<ProductDetailsScreen> createState() =>
      _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends ConsumerState<ProductDetailsScreen> {
  int quantity = 1;
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(recentlyViewedProvider.notifier).add(widget.product);
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final productDetailsState = ref.watch(
      productDetailsProvider(widget.product.slug),
    );
    final recentlyViewedState = ref.watch(recentlyViewedProvider);

    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: EdgeInsets.only(left: width * 0.04),
          child: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: SvgPicture.asset(AppIcons.back),
          ),
        ),
        title: const Text("About"),
        centerTitle: true,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: width * 0.05),
            child: SvgPicture.asset(AppIcons.share),
          ),
        ],
      ),

      body: productDetailsState.when(
        data: (data) {
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.06),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: width * 0.02),
                  Center(
                    child: ProductImagesSlider(
                      product: data,
                      images: data.images,
                    ),
                  ),

                  SizedBox(height: width * 0.03),

                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              data.name,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: width * 0.04,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              '\$ ${data.priceBeforeDiscount}',
                              style: TextStyle(
                                fontSize: width * 0.04,
                                fontWeight: FontWeight.bold,
                                color: AppColors.yellow,
                              ),
                            ),
                          ],
                        ),
                      ),

                      Text(
                        '⭐ ${data.rate}',
                        style: TextStyle(
                          fontSize: width * 0.035,
                          color: AppColors.darkGray,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: width * 0.04),

                  Container(
                    padding: EdgeInsets.all(width * 0.02),
                    decoration: BoxDecoration(
                      color: Color(0xFFEEB504).withValues(alpha: 0.04),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        Text("•"),
                        SizedBox(width: width * 0.02),
                        Expanded(
                          child: Text(
                            data.slug,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: width * 0.05),
                  Divider(),
                  SizedBox(height: width * 0.04),

                  Text(
                    "Description",
                    style: TextStyle(
                      fontSize: width * 0.04,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  SizedBox(height: width * 0.02),

                  Html(
                    data: data.description,
                    style: {
                      "body": Style(
                        fontSize: FontSize(width * 0.035),
                        color: AppColors.lightGray,
                      ),
                    },
                  ),

                  SizedBox(height: width * 0.06),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Buy It Together',
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

                  SizedBox(height: width * 0.04),

                  LayoutBuilder(
                    builder: (context, constraints) {
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 4,
                            child: Column(
                              children: [
                                SmallProductCard(
                                  image: 'assets/images/small_salmon.png',
                                  name: 'Soly Salmon',
                                  price: '\$ 17,230',
                                ),

                                SizedBox(height: constraints.maxWidth * 0.02),

                                SvgPicture.asset(
                                  AppIcons.plus,
                                  height: constraints.maxWidth * 0.05,
                                ),

                                SizedBox(height: constraints.maxWidth * 0.02),

                                SmallProductCard(
                                  image: 'assets/images/small_salmon.png',
                                  name: 'Soly Salmon',
                                  price: '\$ 17,230',
                                ),
                              ],
                            ),
                          ),

                          SizedBox(width: constraints.maxWidth * 0.04),

                          Expanded(
                            flex: 5,
                            child: AspectRatio(
                              aspectRatio: 210 / 290,
                              child: Container(
                                padding: EdgeInsets.all(
                                  constraints.maxWidth * 0.02,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.offWhite,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: constraints.maxWidth * 0.1,
                                          height: constraints.maxWidth * 0.1,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(
                                              12,
                                            ),
                                          ),
                                          child: Icon(
                                            Icons.check,
                                            size: constraints.maxWidth * 0.05,
                                          ),
                                        ),

                                        SizedBox(
                                          width: constraints.maxWidth * 0.02,
                                        ),

                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Soly Salmon',
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  fontSize:
                                                      constraints.maxWidth *
                                                      0.04,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              Text(
                                                '\$ 17,230',
                                                style: TextStyle(
                                                  fontSize:
                                                      constraints.maxWidth *
                                                      0.04,
                                                  fontWeight: FontWeight.bold,
                                                  color: AppColors.yellow,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),

                                    SizedBox(
                                      height: constraints.maxWidth * 0.03,
                                    ),

                                    DropdownButtonFormField<String>(
                                      initialValue: 'Option 1',
                                      items:
                                          ["Option 1", "Option 2", "Option 3"]
                                              .map(
                                                (e) => DropdownMenuItem(
                                                  value: e,
                                                  child: Text(e),
                                                ),
                                              )
                                              .toList(),
                                      onChanged: (value) {},
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.symmetric(
                                          horizontal:
                                              constraints.maxWidth * 0.03,
                                          vertical:
                                              constraints.maxWidth * 0.025,
                                        ),
                                        filled: true,
                                        fillColor: Colors.white,
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                          borderSide: BorderSide.none,
                                        ),
                                      ),
                                    ),

                                    SizedBox(
                                      height: constraints.maxWidth * 0.03,
                                    ),

                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: constraints.maxWidth * 0.1,
                                          height: constraints.maxWidth * 0.1,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(
                                              12,
                                            ),
                                          ),
                                        ),

                                        SizedBox(
                                          width: constraints.maxWidth * 0.02,
                                        ),

                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Soly Salmon',
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  fontSize:
                                                      constraints.maxWidth *
                                                      0.04,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              Text(
                                                '\$ 17,230',
                                                style: TextStyle(
                                                  fontSize:
                                                      constraints.maxWidth *
                                                      0.04,
                                                  fontWeight: FontWeight.bold,
                                                  color: AppColors.yellow,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),

                                    Spacer(),

                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Flexible(
                                          child: Text(
                                            "\$ 17,230",
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontSize:
                                                  constraints.maxWidth * 0.04,
                                              decoration:
                                                  TextDecoration.lineThrough,
                                              color: Colors.red,
                                            ),
                                          ),
                                        ),
                                        Flexible(
                                          child: Text(
                                            "\$ 17,230",
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontSize:
                                                  constraints.maxWidth * 0.045,
                                              fontWeight: FontWeight.w600,
                                              color: AppColors.yellow,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),

                                    SizedBox(
                                      height: constraints.maxWidth * 0.03,
                                    ),

                                    ElevatedButton.icon(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: AppColors.blue,
                                        elevation: 0,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            40,
                                          ),
                                        ),
                                        padding: EdgeInsets.symmetric(
                                          vertical: 15,
                                          horizontal: 30,
                                        ),
                                      ),
                                      onPressed: () {},
                                      icon: SvgPicture.asset(
                                        AppIcons.cartWhite,
                                      ),
                                      label: Text(
                                        "Add to Cart",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),

                  SizedBox(height: width * 0.06),

                  Text(
                    'Recently Viewed',
                    style: TextStyle(
                      fontSize: width * 0.04,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  SizedBox(height: width * 0.04),

                  recentlyViewedState.when(
                    data: (data) {
                      if (data.isEmpty) {
                        return SizedBox();
                      }
                      return StackListWidget(
                        scrollDirection: Axis.horizontal,
                        products: data,
                      );
                    },
                    error: (error, stack) {
                      return Center(child: Text(error.toString()));
                    },
                    loading: () {
                      return const Center(child: CircularProgressIndicator());
                    },
                  ),

                  SizedBox(height: 30),
                ],
              ),
            ),
          );
        },
        error: (error, stack) {
          return Center(child: Text(error.toString()));
        },
        loading: () {
          return const ProductDetailsShimmer();
        },
      ),

      bottomNavigationBar: productDetailsState.when(
        data: (data) {
          final productDetails = data;
          return LayoutBuilder(
            builder: (context, constraints) {
              final width = constraints.maxWidth;

              return Container(
                padding: EdgeInsets.symmetric(
                  horizontal: width * 0.08,
                  vertical: width * 0.07,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 12,
                      color: Colors.black.withValues(alpha: 0.08),
                      offset: Offset(0, -2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          if (quantity > 1) quantity--;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                        child: SvgPicture.asset(
                          AppIcons.minusRounded,
                          height: 25,
                          width: 25,
                        ),
                      ),
                    ),

                    const SizedBox(width: 12),
                    Text(
                      quantity.toString(),
                      style: const TextStyle(fontSize: 18),
                    ),

                    const SizedBox(width: 12),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          quantity++;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                        child: SvgPicture.asset(
                          AppIcons.plusRounded,
                          height: 25,
                          width: 25,
                        ),
                      ),
                    ),
                    Spacer(),

                    Expanded(
                      flex: 4,
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.blue,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                          padding: EdgeInsets.symmetric(
                            vertical: width * 0.04,
                            horizontal: width * 0.08,
                          ),
                        ),
                        onPressed: () async {
                          await ref
                              .read(cartProvider.notifier)
                              .addToCart(
                                productDetails.toProduct(),
                                quantity: quantity,
                              );

                          if (!context.mounted) return;

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Product added to cart'),
                              backgroundColor: Colors.green,
                              duration: Duration(seconds: 2),
                            ),
                          );
                        },
                        icon: SvgPicture.asset(
                          AppIcons.cartWhite,
                          height: width * 0.05,
                        ),
                        label: FittedBox(
                          child: Text(
                            "Add to Cart",
                            style: TextStyle(
                              fontSize: width * 0.04,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
        error: (error, stack) {
          return Center(child: Text(error.toString()));
        },
        loading: () {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  blurRadius: 10,
                  color: Colors.black12,
                  offset: Offset(0, -2),
                ),
              ],
            ),
            child: Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade100,
              child: Row(
                children: [
                  Container(
                    height: 40,
                    width: 120,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),

                  SizedBox(width: 20),

                  Expanded(
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(40),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
