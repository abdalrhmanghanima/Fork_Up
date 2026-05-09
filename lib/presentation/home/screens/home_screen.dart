import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fork_up/core/utils/app_colors.dart';
import 'package:fork_up/core/utils/app_icons.dart';
import 'package:fork_up/presentation/best_seller/screen/best_seller_screen.dart';
import 'package:fork_up/presentation/home/cubit/home_cubit.dart';
import 'package:fork_up/presentation/home/cubit/home_state.dart';
import 'package:fork_up/presentation/home/widgets/category_button.dart';
import 'package:fork_up/presentation/new_arrivals/screen/new_arrivals_screen.dart';
import 'package:fork_up/presentation/offers/screen/offers_screen.dart';
import 'package:fork_up/presentation/offers/widget/offers_widget.dart';
import 'package:fork_up/presentation/shared/widgets/stack_list_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state is HomeLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is HomeSuccess) {
          final data = state.data;
          return Scaffold(
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Container(
                        height: 230,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(data.data.bannerImage),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Positioned(
                        left: 16,
                        top: 70,
                        child: Row(
                          children: [
                            Text(
                              "Login",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(width: 20),
                            Text(
                              "SignUp",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        right: 16,
                        top: 70,
                        child: Row(
                          children: [
                            GestureDetector(
                              child: SvgPicture.asset(AppIcons.search),
                            ),
                            SizedBox(width: 20),
                            GestureDetector(
                              child: SvgPicture.asset(AppIcons.notifications),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        left: 16,
                        bottom: 20,
                        child: Text(
                          "Provide the best\nfood for you",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        'Top Selling Products',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(width: 20),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => BestSellerScreen(),));
                        },
                        child: Text(
                          'See All',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: AppColors.yellow,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  StackListWidget(
                      scrollDirection: Axis.horizontal,
                      products: data.data.bestSellers),
                  SizedBox(height: 13),
                  Padding(
                    padding: const EdgeInsets.only(left: 35),
                    child: Text(
                      'Categories',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(left: 12),
                    child: SizedBox(
                      height: 170,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: data.data.categories.length,
                        itemBuilder: (context, index) {
                          final category = data.data.categories[index];
                          return GestureDetector(
                            onTap: () {},
                            child: Container(
                              width: 140,
                              margin: EdgeInsets.only(right: 12),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(16),
                                    ),
                                    child: SizedBox(
                                      height: 120,
                                      width: double.infinity,
                                      child: CachedNetworkImage(
                                        imageUrl: category.icon,
                                        fit: BoxFit.cover,

                                        fadeInDuration: Duration.zero,
                                        fadeOutDuration: Duration.zero,

                                        placeholder: (context, url) =>
                                            Container(
                                              color: Colors.grey.shade200,
                                            ),

                                        errorWidget: (context, url, error) =>
                                            Icon(Icons.image_not_supported),
                                      ),
                                    ),
                                  ),

                                  SizedBox(height: 12),

                                  Padding(
                                    padding: const EdgeInsets.only(left: 25),
                                    child: Text(
                                      category.name,
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.blue,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 28),
                  Padding(
                    padding: const EdgeInsets.only(left: 12),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,

                      child: Row(
                        children: [

                          CategoryButton(
                            title: "New arrivals",
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const NewArrivalsScreen(),
                                ),
                              );
                            },
                          ),

                          CategoryButton(
                            title: "Offers",
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const OffersScreen(),
                                ),
                              );
                            },
                          ),

                          CategoryButton(
                            title: "Best Sellers",
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const BestSellerScreen(),
                                ),
                              );
                            },
                          ),

                          CategoryButton(
                            title: "Breaded ready to fry",
                            onTap: () {
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        'New Arrival Products',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(width: 20),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => NewArrivalsScreen(),));
                        },
                        child: Text(
                          'See All',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: AppColors.yellow,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  StackListWidget(
                      scrollDirection: Axis.horizontal,
                      products: data.data.newArrivalProducts),
                  SizedBox(height: 24),
                  OffersWidget(
                    margin: EdgeInsets.only(right: 12),
                    height: 150,
                    scrollDirection: Axis.horizontal,
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        'Our Partners',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(width: 20),
                      Text(
                        'See All',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: AppColors.yellow,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.only(left: 12, bottom: 40),
                    child: SizedBox(
                      height: 60,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: data.data.partners.length,
                        itemBuilder: (context, index) {
                          final partner = data.data.partners[index];
                          return Container(
                            width: 120,
                            margin: EdgeInsets.only(right: 7),
                            decoration: BoxDecoration(color: Colors.white),
                            child: CachedNetworkImage(
                              imageUrl: partner.image,
                              fit: BoxFit.cover,

                              fadeInDuration: Duration.zero,
                              fadeOutDuration: Duration.zero,

                              placeholder: (context, url) =>
                                  Container(
                                    color: Colors.grey.shade200,
                                  ),

                              errorWidget: (context, url, error) =>
                                  Icon(Icons.image_not_supported),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        return SizedBox.shrink();
      },
    );
  }
}
