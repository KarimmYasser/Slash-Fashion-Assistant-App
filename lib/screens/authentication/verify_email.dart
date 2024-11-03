import 'package:fashion_assistant/screens/authentication/success_screen.dart';
import 'package:fashion_assistant/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants.dart';

class VerifyEmailScreen extends StatelessWidget {
  const VerifyEmailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              icon: const Icon(Icons.clear),
              onPressed: () => Get.back(),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(Sizes.defaultSpace),
            child: Column(
              children: [
                Image.asset(
                  "assets/animations/sammy-line-man-receives-a-mail.png",
                  width: HelperFunctions.screenWidth() * 0.6,
                ),
                const SizedBox(height: Sizes.spaceBtwSections),
                Text(
                  "Verify your email",
                  style: Theme.of(context).textTheme.headlineMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: Sizes.spaceBtwItems),
                Text(
                  "admin@example.com",
                  style: Theme.of(context).textTheme.labelLarge,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: Sizes.spaceBtwItems),
                Text(
                  "We have sent a verification link to your email address. Please click on the link to verify your email address.",
                  style: Theme.of(context).textTheme.labelMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: Sizes.spaceBtwSections),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => Get.to(
                      () => SuccessScreen(
                        image: "assets/animations/sammy-line-success.png",
                        title: "Your account successfully created!",
                        subtitle:
                            "Welcome to Your Ultimate Shopping Destination: Your Account is Created, Unleash the Joy of Seamless Online Shopping!",
                        onPressed: () {
                          Get.back();
                          Get.back();
                        },
                      ),
                    ),
                    child: const Text("Continue"),
                  ),
                ),
                const SizedBox(height: Sizes.spaceBtwItems),
                SizedBox(
                  width: double.infinity,
                  child: TextButton(
                    onPressed: () {},
                    child: const Text("Resend verification email"),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
