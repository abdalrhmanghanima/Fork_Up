import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fork_up/core/utils/app_colors.dart';
import 'package:fork_up/core/utils/app_icons.dart';
import 'package:fork_up/presentation/home/screens/home.dart';
class Root extends StatefulWidget {
  const Root({super.key});

  @override
  State<Root> createState() => _RootState();
}

class _RootState extends State<Root> {

  int currentScreen = 0;

  final List<Widget> screens = [
    HomeScreen(),

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: currentScreen,
        children: screens,
      ),

      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
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
            currentIndex: currentScreen,
            onTap: (index) {
              setState(() {
                currentScreen = index;
              });
            },
            items: [
              BottomNavigationBarItem(
                icon: SvgPicture.asset(AppIcons.home,
                  colorFilter: ColorFilter.mode(
                    currentScreen == 0 ? AppColors.yellow : AppColors.gray,
                    BlendMode.srcIn,
                  ),
                ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(AppIcons.cart,
                  colorFilter: ColorFilter.mode(
                    currentScreen == 1 ? AppColors.yellow : AppColors.gray,
                    BlendMode.srcIn,
                  ),
                ),
                label: 'Cart',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(AppIcons.box,
                  colorFilter: ColorFilter.mode(
                    currentScreen == 2 ? AppColors.yellow : AppColors.gray,
                    BlendMode.srcIn,
                  ),
                ),
                label: 'Wholesale',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(AppIcons.menu,
                  colorFilter: ColorFilter.mode(
                    currentScreen == 3 ? AppColors.yellow : AppColors.gray,
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