import 'package:flutter/material.dart';
import 'package:gastro_go_app/features/favorite/favorite_screen.dart';
import 'package:gastro_go_app/features/home/home_screen.dart';
import 'package:gastro_go_app/features/settings/settings_screen.dart';
import 'package:gastro_go_app/provider/bottom_nav_provider.dart';
import 'package:gastro_go_app/styles_manager/values_manager.dart';
import 'package:provider/provider.dart';
import 'package:water_drop_nav_bar/water_drop_nav_bar.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final pageController = PageController();
    return Scaffold(
      body: Consumer<BottomNavProvider>(
        builder: (context, value, child) {
          return PageView(
            physics: const NeverScrollableScrollPhysics(),
            onPageChanged: (index) {
              value.setIndexNav(index);
            },
            controller: pageController,
            children: const [
              HomeScreen(),
              FavoriteScreen(),
              SettingsScreen(),
            ],
          );
        },
      ),
      bottomNavigationBar: WaterDropNavBar(
        backgroundColor: Colors.white,
        selectedIndex: context.watch<BottomNavProvider>().indexNav,
        onItemSelected: (index) {
          context.read<BottomNavProvider>().setIndexNav(index);
          pageController.animateToPage(index,
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeOutQuad);
        },
        bottomPadding: AppPadding.p8,
        barItems: [
          BarItem(filledIcon: Icons.home, outlinedIcon: Icons.home_outlined),
          BarItem(
              filledIcon: Icons.favorite, outlinedIcon: Icons.favorite_border),
          BarItem(
              filledIcon: Icons.settings, outlinedIcon: Icons.settings_outlined)
        ],
      ),
    );
  }
}
