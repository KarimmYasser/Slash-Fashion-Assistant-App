import 'package:fashion_assistant/constants.dart';
import 'package:fashion_assistant/tap_map.dart';
import 'package:fashion_assistant/widgets/admin_mode/admin_custom_navbar.dart';
import 'package:fashion_assistant/widgets/admin_mode/brand_manager_navbar.dart';
import 'package:fashion_assistant/widgets/brand_mode/brand_navbar.dart';
import 'package:fashion_assistant/widgets/home_page/custom_navbar.dart';
import 'package:flutter/material.dart';

class BrandAdminTotalScreens extends StatefulWidget {
  const BrandAdminTotalScreens({super.key});

  @override
  State<BrandAdminTotalScreens> createState() => _BrandAdminTotalScreensState();
}

class _BrandAdminTotalScreensState extends State<BrandAdminTotalScreens> {
  int _activeScreen = 0;
  final PageController _pageController = PageController(initialPage: 0);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: OurColors.backgroundColor,
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _activeScreen = index;
            if (_activeScreen == 0) {
              inHome = true;
            } else {
              inHome = false;
            }
          });
        },
        children: [
          screenDetailsBrandAdmin[0]['screenName'],
          screenDetailsBrandAdmin[1]['screenName'],
          screenDetailsBrandAdmin[2]['screenName'],
        ],
      ),
      bottomNavigationBar: CustomBrandAdminNavBar(
        activeScreen: _activeScreen,
        ontap: (index) {
          _pageController.animateToPage(index,
              duration: const Duration(microseconds: 400), curve: Curves.ease);
        },
      ),
    );
  }
}
