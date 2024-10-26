import 'package:fashion_assistant/constants.dart';
import 'package:fashion_assistant/tap_map.dart';
import 'package:fashion_assistant/widgets/custom_navbar.dart';
import 'package:flutter/material.dart';

class TotalScreens extends StatefulWidget {
  const TotalScreens({super.key});

  @override
  State<TotalScreens> createState() => _TotalScreensState();
}

class _TotalScreensState extends State<TotalScreens> {
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
          });
        },
        children: [
          screenDetails[0]['screenName'],
          screenDetails[1]['screenName'],
          screenDetails[2]['screenName'],
          screenDetails[3]['screenName'],
          screenDetails[4]['screenName'],
        ],
      ),
      bottomNavigationBar: CustomNavbar(
        activeScreen: _activeScreen,
        ontap: (index) {
          _pageController.animateToPage(index,
              duration: const Duration(microseconds: 400), curve: Curves.ease);
        },
      ),
    );
  }
}
