import 'package:fashion_assistant/screens/authentication/controllers.onboarding/onboarding_controller.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../constants.dart';
import '../../utils/device/device_utility.dart';

class OnBoardingDotNavigation extends StatelessWidget {
  const OnBoardingDotNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = OnboardingController.instance;
    return Positioned(
      bottom: DeviceUtils.getBottomNavigationBarHeight() + 25,
      left: Sizes.defaultSpace,
      child: SmoothPageIndicator(
        controller: controller.pageController,
        onDotClicked: controller.dotNavigationClick,
        count: 3,
        effect: const ExpandingDotsEffect(
          dotHeight: 6,
          activeDotColor: OurColors.dark,
          dotColor: Colors.grey,
        ),
      ),
    );
  }
}
