import 'package:fashion_assistant/constants.dart';
import 'package:fashion_assistant/tap_map.dart';
import 'package:fashion_assistant/widgets/admin_mode/admin_custom_navbar.dart';
import 'package:fashion_assistant/widgets/brand_mode/brand_navbar.dart';
import 'package:fashion_assistant/widgets/home_page/custom_navbar.dart';
import 'package:flutter/material.dart';

class AdminTotalScreens extends StatefulWidget {
  const AdminTotalScreens({super.key});

  @override
  State<AdminTotalScreens> createState() => _AdminTotalScreensState();
}

class _AdminTotalScreensState extends State<AdminTotalScreens> {
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
          screenDetailsAdmin[0]['screenName'],
          screenDetailsAdmin[1]['screenName'],
          screenDetailsAdmin[2]['screenName'],
          screenDetailsAdmin[3]['screenName'],
          screenDetailsAdmin[4]['screenName'],
        ],
      ),
      bottomNavigationBar: CustomAdminNavBar(
        activeScreen: _activeScreen,
        ontap: (index) {
          _pageController.animateToPage(index,
              duration: const Duration(microseconds: 400), curve: Curves.ease);
        },
      ),
    );
  }
}
