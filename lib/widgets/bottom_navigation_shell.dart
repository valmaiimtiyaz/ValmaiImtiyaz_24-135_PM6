import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../core/constants/app_colors.dart';

class BottomNavigationShell extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const BottomNavigationShell({super.key, required this.navigationShell});

  void _onTap(BuildContext context, int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: navigationShell,

      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: isDark
                  ? AppColors.champagne.withOpacity(0.2)
                  : AppColors.lightNavyBlue.withOpacity(0.2),
              width: 1.0,
            ),
          ),
        ),

        child: NavigationBar(
          selectedIndex: navigationShell.currentIndex,
          onDestinationSelected: (index) => _onTap(context, index),
          backgroundColor: isDark ? AppColors.coffeeBean : AppColors.champagne,
          indicatorColor: AppColors.blazeOrange.withOpacity(0.2),
          destinations: [
            NavigationDestination(
              icon: Icon(
                Icons.home_outlined,
                color: isDark ? AppColors.champagne : AppColors.lightNavyBlue,
              ),
              selectedIcon: const Icon(
                Icons.home_rounded,
                color: AppColors.blazeOrange,
              ),
              label: 'Beranda',
            ),
            NavigationDestination(
              icon: Icon(
                Icons.person_outline_rounded,
                color: isDark ? AppColors.champagne : AppColors.lightNavyBlue,
              ),
              selectedIcon: const Icon(
                Icons.person_rounded,
                color: AppColors.blazeOrange,
              ),
              label: 'Profil',
            ),
          ],
        ),
      ),
    );
  }
}
