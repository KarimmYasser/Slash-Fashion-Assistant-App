import 'package:fashion_assistant/screens/authentication/controllers.onboarding/onboarding_controller.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';
import '../../utils/device/device_utility.dart';

class OnBoardingSkip extends StatelessWidget {
  const OnBoardingSkip({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: DeviceUtils.getAppBarHeight(),
      right: Sizes.defaultSpace,
      child: TextButton(
        onPressed: () => OnboardingController.instance.skipPage(),
        child: Text('Skip', style: Theme.of(context).textTheme.bodyLarge),
      ),
    );
  }
}
