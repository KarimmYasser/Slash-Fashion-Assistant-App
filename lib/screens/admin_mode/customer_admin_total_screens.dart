import 'package:fashion_assistant/constants.dart';
import 'package:fashion_assistant/tap_map.dart';
import 'package:fashion_assistant/widgets/admin_mode/admin_custom_navbar.dart';
import 'package:fashion_assistant/widgets/admin_mode/customer_admin_navbar.dart';
import 'package:fashion_assistant/widgets/brand_mode/brand_navbar.dart';
import 'package:fashion_assistant/widgets/home_page/custom_navbar.dart';
import 'package:flutter/material.dart';

class CustomerAdminTotalScreens extends StatefulWidget {
  const CustomerAdminTotalScreens({super.key});

  @override
  State<CustomerAdminTotalScreens> createState() =>
      _CustomerAdminTotalScreensState();
}

class _CustomerAdminTotalScreensState extends State<CustomerAdminTotalScreens> {
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
          screenDetailsCustomerAdmin[0]['screenName'],
          screenDetailsCustomerAdmin[1]['screenName'],
          screenDetailsCustomerAdmin[2]['screenName'],
        ],
      ),
      bottomNavigationBar: CustomCustomerAdminNavBar(
        activeScreen: _activeScreen,
        ontap: (index) {
          _pageController.animateToPage(index,
              duration: const Duration(microseconds: 400), curve: Curves.ease);
        },
      ),
    );
  }
}
