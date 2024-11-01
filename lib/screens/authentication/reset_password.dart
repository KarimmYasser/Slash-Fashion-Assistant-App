import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../constants.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => Get.back(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(Sizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Reset Password",
                  style: Theme.of(context).textTheme.headlineMedium),
              const SizedBox(height: Sizes.spaceBtwItems),
              Text(
                  "Enter your new password and confirm it to reset your password.",
                  style: Theme.of(context).textTheme.labelMedium),
              const SizedBox(height: Sizes.spaceBtwSections * 2),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'New Password',
                  hintText: 'Enter your new password',
                  prefixIcon: Icon(Iconsax.direct_right),
                ),
              ),
              const SizedBox(height: Sizes.spaceBtwInputFields),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Confirm Password',
                  hintText: 'Enter your new password again',
                  prefixIcon: Icon(Iconsax.direct_right),
                ),
              ),
              const SizedBox(height: Sizes.spaceBtwSections),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text('Submit'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
