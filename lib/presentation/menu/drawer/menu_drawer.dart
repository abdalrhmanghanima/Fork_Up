import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fork_up/core/utils/app_colors.dart';
import 'package:fork_up/core/utils/app_icons.dart';
import 'package:fork_up/presentation/best_seller/screen/best_seller_screen.dart';
import 'package:fork_up/presentation/menu/cubit/navigation_cubit.dart';
import 'package:fork_up/presentation/menu/widget/list_tile_widget.dart';
import 'package:fork_up/presentation/new_arrivals/screen/new_arrivals_screen.dart';
import 'package:fork_up/presentation/offers/screen/offers_screen.dart';
import 'package:fork_up/presentation/wish_list/screen/wish_list_screen.dart';

class MenuDrawer extends StatefulWidget {
  const MenuDrawer({super.key});

  @override
  State<MenuDrawer> createState() => _MenuDrawerState();
}

class _MenuDrawerState extends State<MenuDrawer> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {

    return Drawer(
      child: ListView(
        children: [
          ListTileWidget(
            title: "Home",
            onTap: (){
              Navigator.pop(context);
              context.read<NavigationCubit>().changeTab(0);
            },
          ),
          Padding(
            padding: const EdgeInsets.only(left: 18, right: 22),
            child: Divider(color: AppColors.lightGray, height: 0, thickness: 0.7),
          ),
          ListTileWidget(
            title: "Profile",
            onTap: (){},
          ),
          Padding(
            padding: const EdgeInsets.only(left: 18, right: 22),
            child: Divider(color: AppColors.lightGray, height: 0, thickness: 0.7),
          ),
          Theme(
            data: Theme.of(context).copyWith(
              dividerColor: Colors.transparent,
            ),
            child: ExpansionTile(
              title: Text(
                "Shop",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              trailing: isExpanded?
              SvgPicture.asset(AppIcons.arrowDown):
              SvgPicture.asset(AppIcons.arrowRight),

              onExpansionChanged: (value) {
                setState(() {
                  isExpanded = value;
                });
              },
              iconColor: Colors.black,
              collapsedIconColor: Colors.black,
              children: [
                ListTile(
                  titleAlignment: ListTileTitleAlignment.top,
                  minVerticalPadding: 0,
                  minTileHeight: 30,
                  title: Text("Shrimps", style: TextStyle(color: Colors.grey)),
                ),
                ListTile(
                  minVerticalPadding: 0,
                  minTileHeight: 30,
                  title: Text("Fresh Salmon", style: TextStyle(color: Colors.grey)),
                ),
                ListTile(
                  minVerticalPadding: 0,
                  minTileHeight: 30,
                  title: Text("Local Fish", style: TextStyle(color: Colors.grey)),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 18, right: 22),
            child: Divider(color: AppColors.lightGray, height: 0, thickness: 0.7),
          ),
          ListTileWidget(
            title: "offers",
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => OffersScreen(),));
            },
          ),
          Padding(
            padding: const EdgeInsets.only(left: 18, right: 22),
            child: Divider(color: AppColors.lightGray, height: 0, thickness: 0.7),
          ),
          ListTileWidget(
            title: "New Arrivals",
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => NewArrivalsScreen(),));
            },
          ),
          Padding(
            padding: const EdgeInsets.only(left: 18, right: 22),
            child: Divider(color: AppColors.lightGray, height: 0, thickness: 0.7),
          ),
          ListTileWidget(
            title: "Best Seller",
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => BestSellerScreen(),));
            },
          ),
          Padding(
            padding: const EdgeInsets.only(left: 18, right: 22),
            child: Divider(color: AppColors.lightGray, height: 0, thickness: 0.7),
          ),
          ListTileWidget(
            title: "Wish List",
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => WishListScreen(),));

            },
          ),
          Padding(
            padding: const EdgeInsets.only(left: 18, right: 22),
            child: Divider(color: AppColors.lightGray, height: 0, thickness: 0.7),
          ),
          ListTileWidget(
            title: "Contact Us",
            onTap: (){},
          ),
          Padding(
            padding: const EdgeInsets.only(left: 18, right: 22),
            child: Divider(color: AppColors.lightGray, height: 0, thickness: 0.7),
          ),
          ListTile(
            title: Text(
              "Sign Out",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500,
                color: Colors.red
              ),
            ),
            trailing: SvgPicture.asset(AppIcons.arrowRight),
            onTap: (){},
          ),
          Padding(
            padding: const EdgeInsets.only(left: 18, right: 22),
            child: Divider(color: AppColors.lightGray, height: 0, thickness: 0.7),
          ),
        ],
      ),
    );
  }
}
