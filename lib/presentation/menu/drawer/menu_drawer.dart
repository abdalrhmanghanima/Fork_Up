import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fork_up/core/utils/app_colors.dart';
import 'package:fork_up/core/utils/app_icons.dart';
import 'package:fork_up/domain/categories/arguments/categories_details_arguments.dart';
import 'package:fork_up/presentation/auth/provider/chek_login/check_login_provider.dart';
import 'package:fork_up/presentation/best_seller/screen/best_seller_screen.dart';
import 'package:fork_up/presentation/categories/provider/categories_provider.dart';
import 'package:fork_up/presentation/categories/screen/categories_details_screen.dart';
import 'package:fork_up/presentation/menu/provider/navigation_provider.dart';
import 'package:fork_up/presentation/menu/widget/list_tile_widget.dart';
import 'package:fork_up/presentation/menu/widget/sign_out_dialog.dart';
import 'package:fork_up/presentation/new_arrivals/screen/new_arrivals_screen.dart';
import 'package:fork_up/presentation/offers/screen/offers_screen.dart';
import 'package:fork_up/presentation/profile/screen/profile_screen.dart';
import 'package:fork_up/presentation/wish_list/screen/wish_list_screen.dart';

class MenuDrawer extends ConsumerStatefulWidget {
  const MenuDrawer({super.key});

  @override
  ConsumerState<MenuDrawer> createState() => _MenuDrawerState();
}

class _MenuDrawerState extends ConsumerState<MenuDrawer> {
  bool isExpanded = false;
  Set<int> expandedCategories = {};
  @override
  Widget build(BuildContext context) {
    final isLogged = ref.watch(checkLoginProvider);
    return Drawer(
      child: ListView(
        children: [
          ListTileWidget(
            title: "Home",
            onTap: () {
              Navigator.pop(context);
              ref.read(navigationProvider.notifier).changeTab(0);
            },
          ),
          Padding(
            padding: const EdgeInsets.only(left: 18, right: 22),
            child: Divider(
              color: AppColors.lightGray,
              height: 0,
              thickness: 0.7,
            ),
          ),
          isLogged
              ? ListTileWidget(
                  title: "Profile",
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ProfileScreen()),
                    );
                  },
                )
              : SizedBox.shrink(),
          Padding(
            padding: const EdgeInsets.only(left: 18, right: 22),
            child: Divider(
              color: AppColors.lightGray,
              height: 0,
              thickness: 0.7,
            ),
          ),
          Theme(
            data: Theme.of(context).copyWith(dividerColor: Colors.transparent),

            child: Consumer(
              builder: (context, ref, child) {
                final categoriesState = ref.watch(categoriesProvider);

                return categoriesState.when(
                  data: (data) {
                    return ExpansionTile(
                      title: const Text(
                        "Shop",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),

                      trailing: isExpanded
                          ? SvgPicture.asset(AppIcons.arrowDown)
                          : SvgPicture.asset(AppIcons.arrowRight),

                      onExpansionChanged: (value) {
                        setState(() {
                          isExpanded = value;
                        });
                      },

                      iconColor: Colors.black,
                      collapsedIconColor: Colors.black,

                      children: data.data.map((category) {
                        final isCategoryExpanded = expandedCategories.contains(
                          category.id,
                        );

                        return Padding(
                          padding: const EdgeInsets.only(left: 12, right: 8),
                          child: ExpansionTile(
                            tilePadding: EdgeInsets.zero,

                            childrenPadding: EdgeInsets.zero,

                            iconColor: Colors.black,

                            collapsedIconColor: Colors.black,

                            onExpansionChanged: (value) {
                              setState(() {
                                if (value) {
                                  expandedCategories.add(category.id);
                                } else {
                                  expandedCategories.remove(category.id);
                                }
                              });
                            },

                            trailing: category.subCategory.isNotEmpty
                                ? isCategoryExpanded
                                      ? SvgPicture.asset(AppIcons.arrowDown)
                                      : SvgPicture.asset(AppIcons.arrowRight)
                                : const SizedBox(),

                            title: GestureDetector(
                              onTap: category.subCategory.isEmpty
                                  ? () {
                                      Navigator.push(
                                        context,

                                        MaterialPageRoute(
                                          builder: (_) =>
                                              CategoriesDetailsScreen(
                                                arguments: CategoryDetailsArgs(
                                                  id: category.id,

                                                  name: category.name,

                                                  subCategories:
                                                      category.subCategory,
                                                ),
                                              ),
                                        ),
                                      );
                                    }
                                  : null,

                              child: Text(
                                category.name,

                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),

                            children: category.subCategory.isNotEmpty
                                ? category.subCategory.map((sub) {
                                    return Padding(
                                      padding: const EdgeInsets.only(left: 20),

                                      child: ListTile(
                                        onTap: () {
                                          Navigator.push(
                                            context,

                                            MaterialPageRoute(
                                              builder: (_) =>
                                                  CategoriesDetailsScreen(
                                                    arguments:
                                                        CategoryDetailsArgs(
                                                          id: category.id,

                                                          name: category.name,

                                                          subCategories:
                                                              category
                                                                  .subCategory,
                                                        ),
                                                  ),
                                            ),
                                          );
                                        },

                                        minVerticalPadding: 0,

                                        minTileHeight: 30,

                                        title: Text(
                                          sub.name,

                                          style: const TextStyle(
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ),
                                    );
                                  }).toList()
                                : [],
                          ),
                        );
                      }).toList(),
                    );
                  },

                  loading: () {
                    return const Center(child: CircularProgressIndicator());
                  },

                  error: (error, stack) {
                    return Text(error.toString());
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 18, right: 22),
            child: Divider(
              color: AppColors.lightGray,
              height: 0,
              thickness: 0.7,
            ),
          ),
          ListTileWidget(
            title: "offers",
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => OffersScreen()),
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.only(left: 18, right: 22),
            child: Divider(
              color: AppColors.lightGray,
              height: 0,
              thickness: 0.7,
            ),
          ),
          ListTileWidget(
            title: "New Arrivals",
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NewArrivalsScreen()),
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.only(left: 18, right: 22),
            child: Divider(
              color: AppColors.lightGray,
              height: 0,
              thickness: 0.7,
            ),
          ),
          ListTileWidget(
            title: "Best Seller",
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => BestSellerScreen()),
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.only(left: 18, right: 22),
            child: Divider(
              color: AppColors.lightGray,
              height: 0,
              thickness: 0.7,
            ),
          ),
          ListTileWidget(
            title: "Wish List",
            onTap: () {
              isLogged
                  ? Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => WishListScreen()),
                    )
                  : SizedBox.shrink();
            },
          ),
          Padding(
            padding: const EdgeInsets.only(left: 18, right: 22),
            child: Divider(
              color: AppColors.lightGray,
              height: 0,
              thickness: 0.7,
            ),
          ),
          ListTileWidget(title: "Contact Us", onTap: () {}),
          Padding(
            padding: const EdgeInsets.only(left: 18, right: 22),
            child: Divider(
              color: AppColors.lightGray,
              height: 0,
              thickness: 0.7,
            ),
          ),
          isLogged
              ? ListTile(
                  title: Text(
                    "Sign Out",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.red,
                    ),
                  ),
                  trailing: SvgPicture.asset(AppIcons.arrowRight),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return const SignOutDialog();
                      },
                    );
                  },
                )
              : SizedBox.shrink(),
          Padding(
            padding: const EdgeInsets.only(left: 18, right: 22),
            child: Divider(
              color: AppColors.lightGray,
              height: 0,
              thickness: 0.7,
            ),
          ),
        ],
      ),
    );
  }
}
