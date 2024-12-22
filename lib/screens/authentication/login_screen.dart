import 'package:get/get.dart';

import '../../widgets/login_page/login_form.dart';
import '../../widgets/login_page/page_header.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';
import 'brand_signup_screen.dart';

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
              const SizedBox(height: Sizes.spaceBtwSections),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Are you a Brand?',
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                  TextButton(
                    onPressed: () => Get.to(() => const BrandSignupScreen()),
                    child: Text(
                      'Register here',
                      style: Theme.of(context)
                          .textTheme
                          .labelMedium!
                          .apply(color: OurColors.primaryColor),
                    ),
                  ),
                ],
              ),
              // const SizedBox(height: Sizes.spaceBtwItems),
              // SizedBox(
              //   width: double.infinity,
              //   child: OutlinedButton(
              //       style: Theme.of(context)
              //           .outlinedButtonTheme
              //           .style!
              //           .copyWith(
              //               backgroundColor: const WidgetStatePropertyAll(
              //                   OurColors.secondaryColor),
              //               foregroundColor:
              //                   const WidgetStatePropertyAll(OurColors.light)),
              //       onPressed: () => Get.to(() => const BrandLoginScreen()),
              //       child: const Text('Sign In as a Brand')),
              // ),
              //SocialButtons(),
            ],
          ),
        ),
      ),
    );
  }
}
