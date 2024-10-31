import 'package:fashion_assistant/screens/authentication/controllers.onboarding/onboarding_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widgets/onboarding_page/onboarding_dot_navigation.dart';
import '../../widgets/onboarding_page/onboarding_next_button.dart';
import '../../widgets/onboarding_page/onboarding_page.dart';
import '../../widgets/onboarding_page/onboarding_skip.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OnboardingController());
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: controller.pageController,
            onPageChanged: controller.updatePageIndicator,
            children: const [
              OnBoardingPage(
                image: onBoardingImage1,
                headlineText: "Choose your product",
                bodyText:
                    "Welcome to a World of Limitless Choices - Your Perfect Product Awaits!",
              ),
              OnBoardingPage(
                image: onBoardingImage2,
                headlineText: "Select Payment Method",
                bodyText:
                    "For Seamless Transactions, Choose Your Payment Path - Your Convenience, Our Priority!",
              ),
              OnBoardingPage(
                image: onBoardingImage3,
                headlineText: "Deliver at your door step",
                bodyText:
                    "From Our Doorstep to Yours - Swift, Secure, and Contactless Delivery!",
              ),
            ],
          ),
          const OnBoardingSkip(),
          const OnBoardingDotNavigation(),
          const OnBoardingNextButton(),
        ],
      ),
    );
  }
}

const String onBoardingImage1 =
    "assets/onboarding_images/sammy-line-searching.gif";
const String onBoardingImage2 =
    "assets/onboarding_images/sammy-line-shopping.gif";
const String onBoardingImage3 =
    "assets/onboarding_images/sammy-line-delivery.gif";
