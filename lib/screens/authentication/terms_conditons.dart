import 'package:get/get.dart';

import '../../constants.dart';
import 'package:flutter/material.dart';

import 'controllers/signup_controller.dart';

class TermsAndConditions extends StatelessWidget {
  const TermsAndConditions({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = SignupController.instance;
    return Row(
      children: [
        SizedBox(
          width: 24,
          height: 24,
          child: Obx(
            () => Checkbox(
              value: controller.PrivacyPolicey.value,
              onChanged: (value) => controller.togglePrivacyPolicey(),
            ),
          ),
        ),
        const SizedBox(width: Sizes.spaceBtwItems),
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                  text: "I agree to ",
                  style: Theme.of(context).textTheme.bodySmall),
              TextSpan(
                text: "Privacy Policy ",
                style: Theme.of(context).textTheme.bodyMedium!.apply(
                      color: OurColors.primaryColor,
                      decoration: TextDecoration.underline,
                      decorationColor: OurColors.primaryColor,
                    ),
              ),
              TextSpan(
                  text: "and ", style: Theme.of(context).textTheme.bodySmall),
              TextSpan(
                text: "Terms of use.",
                style: Theme.of(context).textTheme.bodyMedium!.apply(
                      color: OurColors.primaryColor,
                      decoration: TextDecoration.underline,
                      decorationColor: OurColors.primaryColor,
                    ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
