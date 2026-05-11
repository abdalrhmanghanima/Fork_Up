import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fork_up/core/utils/app_colors.dart';
import 'package:fork_up/core/utils/app_icons.dart';
import 'package:fork_up/presentation/cart/screens/cart_screen.dart';
import 'package:fork_up/presentation/home/screens/home_screen.dart';
import 'package:fork_up/presentation/menu/drawer/menu_drawer.dart';
import 'package:fork_up/presentation/menu/provider/navigation_provider.dart';
import 'package:fork_up/presentation/whole_sale/screen/whole_sale_screen.dart';
class Root extends ConsumerStatefulWidget {
  const Root({super.key});

  @override
  ConsumerState<Root> createState() => _RootState();
}

class _RootState extends ConsumerState<Root> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();


  final List<Widget> screens = [
    HomeScreen(),
    CartScreen(),
    WholeSaleScreen(),
    SizedBox(),

  ];

  @override
  Widget build(BuildContext context) {
    final currentIndex =ref.watch(navigationProvider);
        return Scaffold(
          key: scaffoldKey,
          drawer: MenuDrawer(),
          body: IndexedStack(
            index: currentIndex,
            children: screens,
          ),

          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 10,
                  spreadRadius: 1,
                  offset: Offset(0, -3),
                ),
              ],
            ),
            padding: const EdgeInsets.all(10),
            child: SizedBox(
              height: 90,
              child: BottomNavigationBar(
                elevation: 0,
                backgroundColor: Colors.transparent,
                type: BottomNavigationBarType.fixed,
                selectedItemColor: AppColors.yellow,
                unselectedItemColor: AppColors.gray,
                currentIndex: currentIndex,
                onTap: (index) {
                  if(index ==3){
                    scaffoldKey.currentState!.openDrawer();
                    return;
                  }
                  ref.read(navigationProvider.notifier).changeTab(index);
                },
                items: [
                  BottomNavigationBarItem(
                    icon: SvgPicture.asset(AppIcons.home,
                      colorFilter: ColorFilter.mode(
                        currentIndex == 0 ? AppColors.yellow : AppColors.gray,
                        BlendMode.srcIn,
                      ),
                    ),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: SvgPicture.asset(AppIcons.mdiCart,
                      colorFilter: ColorFilter.mode(
                        currentIndex == 1 ? AppColors.yellow : AppColors.gray,
                        BlendMode.srcIn,
                      ),
                    ),
                    label: 'Cart',
                  ),
                  BottomNavigationBarItem(
                    icon: SvgPicture.asset(AppIcons.box,
                      colorFilter: ColorFilter.mode(
                        currentIndex == 2 ? AppColors.yellow : AppColors.gray,
                        BlendMode.srcIn,
                      ),
                    ),
                    label: 'Wholesale',
                  ),
                  BottomNavigationBarItem(
                    icon: SvgPicture.asset(AppIcons.menu,
                      colorFilter: ColorFilter.mode(
                        currentIndex == 3 ? AppColors.yellow : AppColors.gray,
                        BlendMode.srcIn,
                      ),
                    ),
                    label: 'Menu',
                  ),
                ],
              ),
            ),
          ),
        );
  }
}