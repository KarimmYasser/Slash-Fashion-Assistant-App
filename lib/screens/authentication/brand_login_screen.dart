import 'package:fashion_assistant/widgets/common/appbar.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../utils/helpers/validation.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';
import 'controllers/login_controller.dart';
import 'forget_password.dart';

class BrandLoginScreen extends StatelessWidget {
  const BrandLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    return Scaffold(
      appBar: const Appbar(
        title: Text('Brand Login'),
        showBackButton: true,
      ),
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
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: Sizes.spaceBtwSections),
                child: Form(
                  key: controller.loginBrandFormKey,
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        controller: controller.email,
                        validator: (value) => Validator.validateEmail(value),
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Iconsax.direct_right),
                          labelText: 'Email',
                          hintText: 'Enter your email',
                        ),
                      ),
                      const SizedBox(height: Sizes.spaceBtwInputFields),
                      Obx(
                        () => TextFormField(
                          controller: controller.password,
                          validator: (value) =>
                              Validator.validateEmptyText('Password', value),
                          obscureText: controller.hidePassword.value,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Iconsax.password_check),
                            labelText: 'Password',
                            hintText: 'Enter your password',
                            suffixIcon: IconButton(
                              icon: Icon(controller.hidePassword.value
                                  ? Iconsax.eye_slash
                                  : Iconsax.eye),
                              onPressed: () => controller.hidePassword.value =
                                  !controller.hidePassword.value,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: Sizes.spaceBtwInputFields / 2),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Obx(
                                () => Checkbox(
                                  value: controller.rememberMe.value,
                                  onChanged: (bool? value) => controller
                                      .rememberMe
                                      .value = !controller.rememberMe.value,
                                ),
                              ),
                              const Text('Remember me'),
                            ],
                          ),
                          TextButton(
                            onPressed: () =>
                                Get.to(() => const ForgetPasswordScreen()),
                            child: const Text(
                              'Forgot Password?',
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: Sizes.spaceBtwInputFields),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                            onPressed: () => controller.login('Brand'),
                            child: const Text('Sign in')),
                      ),
                      const SizedBox(height: Sizes.spaceBtwItems),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
