import 'package:fashion_assistant/constants.dart';
import 'package:fashion_assistant/tap_map.dart';
import 'package:fashion_assistant/widgets/brand_mode/brand_navbar.dart';
import 'package:fashion_assistant/widgets/home_page/custom_navbar.dart';
import 'package:flutter/material.dart';

class BrandTotalScreens extends StatefulWidget {
  const BrandTotalScreens({super.key});

  @override
  State<BrandTotalScreens> createState() => _BrandTotalScreensState();
}

class _BrandTotalScreensState extends State<BrandTotalScreens> {
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
          screenDetailsBrand[0]['screenName'],
          screenDetailsBrand[1]['screenName'],
          screenDetailsBrand[2]['screenName'],
        ],
      ),
      bottomNavigationBar: BrandCustomNavbar(
        activeScreen: _activeScreen,
        ontap: (index) {
          _pageController.animateToPage(index,
              duration: const Duration(microseconds: 400), curve: Curves.ease);
        },
      ),
    );
  }
}
