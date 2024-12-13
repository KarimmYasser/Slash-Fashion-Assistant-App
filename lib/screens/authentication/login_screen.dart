import 'package:fashion_assistant/screens/authentication/brand_login_screen.dart';
import 'package:fashion_assistant/screens/create_avatar/male_or_female.dart';
import 'package:get/get.dart';

import '../../widgets/login_page/login_form.dart';
import '../../widgets/login_page/page_header.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';
import '../../widgets/login_signup/form_divider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            Sizes.defaultSpace,
            Sizes.appBarHeight,
            Sizes.defaultSpace,
            Sizes.defaultSpace,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const LoginPageHeader(),
              const LoginPageForm(),
              const FormDivider(
                text: 'Or',
              ),
              const SizedBox(height: Sizes.spaceBtwSections),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                    style: Theme.of(context)
                        .outlinedButtonTheme
                        .style!
                        .copyWith(
                            backgroundColor: const WidgetStatePropertyAll(
                                OurColors.darkerGrey),
                            foregroundColor:
                                const WidgetStatePropertyAll(OurColors.light)),
                    onPressed: () => Get.offAll(() => const MaleOrFemale()),
                    child: const Text('Continue as a Guest')),
              ),
              const SizedBox(height: Sizes.spaceBtwItems),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                    style: Theme.of(context)
                        .outlinedButtonTheme
                        .style!
                        .copyWith(
                            backgroundColor: const WidgetStatePropertyAll(
                                OurColors.secondaryColor),
                            foregroundColor:
                                const WidgetStatePropertyAll(OurColors.light)),
                    onPressed: () => Get.to(() => const BrandLoginScreen()),
                    child: const Text('Sign In as a Brand')),
              ),
              //SocialButtons(),
            ],
          ),
        ),
      ),
    );
  }
}
