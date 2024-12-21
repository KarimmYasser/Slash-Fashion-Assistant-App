import 'package:fashion_assistant/constants.dart';
import 'package:fashion_assistant/tap_map.dart';
import 'package:fashion_assistant/widgets/admin_mode/admin_custom_navbar.dart';
import 'package:flutter/material.dart';

class SuperAdminTotalScreens extends StatefulWidget {
  const SuperAdminTotalScreens({super.key});

  @override
  State<SuperAdminTotalScreens> createState() => _SuperAdminTotalScreensState();
}

class _SuperAdminTotalScreensState extends State<SuperAdminTotalScreens> {
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
          screenDetailsSuperAdmin[0]['screenName'],
          screenDetailsSuperAdmin[1]['screenName'],
          screenDetailsSuperAdmin[2]['screenName'],
          screenDetailsSuperAdmin[3]['screenName'],
          screenDetailsSuperAdmin[4]['screenName'],
          screenDetailsSuperAdmin[5]['screenName'],
        ],
      ),
      bottomNavigationBar: CustomSuperAdminNavBar(
        activeScreen: _activeScreen,
        ontap: (index) {
          _pageController.animateToPage(index,
              duration: const Duration(microseconds: 400), curve: Curves.ease);
        },
      ),
    );
  }
}
