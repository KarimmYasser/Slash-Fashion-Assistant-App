import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../constants.dart';
import '../../screens/authentication/controllers.onboarding/onboarding_controller.dart';
import '../../utils/device/device_utility.dart';

class OnBoardingNextButton extends StatelessWidget {
  const OnBoardingNextButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: DeviceUtils.getBottomNavigationBarHeight(),
      right: Sizes.defaultSpace,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            shape: const CircleBorder(),
            backgroundColor: OurColors.black,
            side: const BorderSide(color: OurColors.black)),
        onPressed: () => OnboardingController.instance.nextPage(),
        child: const Icon(Iconsax.arrow_right_3),
      ),
    );
  }
}
