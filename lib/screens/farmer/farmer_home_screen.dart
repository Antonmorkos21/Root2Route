import 'package:flutter/material.dart';
import 'package:root2route/core/theme/app_colors.dart';
import 'package:root2route/core/responsive/app_sizes.dart';
import 'package:root2route/screens/account_screen.dart';
import 'package:root2route/screens/farmer/crops_screen.dart';
import 'package:root2route/screens/farmer/market_screen.dart';
import 'package:root2route/screens/farmer/scan_screen.dart';
import 'package:root2route/screens/notifications_screen.dart';

class FarmerHomeScreen extends StatefulWidget {
  const FarmerHomeScreen({super.key});

  @override
  State<FarmerHomeScreen> createState() => _FarmerHomeScreenState();
}

class _FarmerHomeScreenState extends State<FarmerHomeScreen> {
  int index = 0;

  final screens = const [
    CropsScreen(),
    ScanScreen(),
    MarketScreen(),
    AccountScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //  appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0),
      extendBody: true,
      body: screens[index],
      bottomNavigationBar: Container(
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: AppColors.iconPrimary,
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 16,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: NavigationBarTheme(
            data: const NavigationBarThemeData(
              indicatorColor: AppColors.primary,
              labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
            ),
            child: Padding(
              padding: EdgeInsets.only(top: 15, bottom: 0),
              child: NavigationBar(
                height: 30,
                backgroundColor: Colors.transparent,
                selectedIndex: index,
                onDestinationSelected: (i) => setState(() => index = i),
                destinations: [
                  NavigationDestination(
                    icon: Icon(Icons.grass, color: AppColors.iconSecondary),
                    selectedIcon: Icon(
                      Icons.grass_rounded,
                      color: AppColors.iconPrimary,
                    ),
                    label: "Crops",
                  ),
                  NavigationDestination(
                    icon: Icon(
                      Icons.camera_alt_sharp,
                      color: AppColors.iconSecondary,
                    ),
                    selectedIcon: Icon(
                      Icons.camera_enhance_outlined,
                      color: AppColors.iconPrimary,
                    ),
                    label: "Scan",
                  ),

                  NavigationDestination(
                    icon: Icon(
                      Icons.shopping_bag_outlined,
                      color: AppColors.iconSecondary,
                    ),
                    selectedIcon: Icon(
                      Icons.shopping_basket_outlined,
                      color: AppColors.iconPrimary,
                    ),
                    label: "Market",
                  ),

                  NavigationDestination(
                    icon: Icon(
                      Icons.person_4_outlined,
                      color: AppColors.iconSecondary,
                    ),
                    selectedIcon: Icon(
                      Icons.person,
                      color: AppColors.iconPrimary,
                    ),
                    label: "Account",
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
