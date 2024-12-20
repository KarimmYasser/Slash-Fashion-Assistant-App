import 'package:fashion_assistant/utils/helpers/validation.dart';
import 'package:get/get.dart';
import 'package:phone_input/phone_input_package.dart';

import '../../constants.dart';
import '../../screens/authentication/controllers/signup_controller.dart';
import '../../screens/authentication/terms_conditons.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import 'city_picker.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignupController());
    return Form(
      key: controller.signupFormKey,
      child: Column(
        children: [
          // First Name and Last Name
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  validator: (value) =>
                      Validator.validateEmptyText('Field', value),
                  controller: controller.firstName,
                  decoration: const InputDecoration(
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    prefixIcon: Icon(Iconsax.user),
                    hintText: 'First Name',
                  ),
                ),
              ),
              const SizedBox(width: Sizes.spaceBtwInputFields),
              Expanded(
                child: TextFormField(
                  validator: (value) =>
                      Validator.validateEmptyText('Field', value),
                  controller: controller.lastName,
                  decoration: const InputDecoration(
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    prefixIcon: Icon(Iconsax.user),
                    hintText: 'Last Name',
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: Sizes.spaceBtwInputFields),

          // Username
          TextFormField(
            validator: (value) =>
                Validator.validateEmptyText('Username', value),
            controller: controller.userName,
            expands: false,
            decoration: const InputDecoration(
              floatingLabelBehavior: FloatingLabelBehavior.always,
              prefixIcon: Icon(Iconsax.user_edit),
              hintText: 'Username',
            ),
          ),
          const SizedBox(height: Sizes.spaceBtwInputFields),

          // Email
          TextFormField(
            validator: (value) => Validator.validateEmail(value),
            controller: controller.email,
            expands: false,
            decoration: const InputDecoration(
              floatingLabelBehavior: FloatingLabelBehavior.always,
              prefixIcon: Icon(Iconsax.direct),
              hintText: 'E-Mail',
            ),
          ),
          const SizedBox(height: Sizes.spaceBtwInputFields),

          // Password
          Obx(
            () => TextFormField(
              validator: (value) => Validator.validatePassword(value),
              controller: controller.password,
              obscureText: !controller.isPasswordVisible.value,
              expands: false,
              decoration: InputDecoration(
                floatingLabelBehavior: FloatingLabelBehavior.always,
                prefixIcon: const Icon(Iconsax.password_check),
                suffixIcon: IconButton(
                  icon: Icon(controller.isPasswordVisible.value
                      ? Iconsax.eye
                      : Iconsax.eye_slash),
                  onPressed: () => controller.togglePassword(),
                ),
                hintText: 'Password',
              ),
            ),
          ),
          const SizedBox(height: Sizes.spaceBtwInputFields),

          DropdownButtonFormField<String>(
            icon: const Icon(Icons.assignment_ind_outlined),
            items: const [
              DropdownMenuItem(value: 'male', child: Text('Male')),
              DropdownMenuItem(value: 'female', child: Text('Female')),
            ],
            validator: (value) => Validator.validateEmptyText('Field', value),
            onChanged: (value) {
              controller.gender = value;
            },
            hint: const Text('Gender'),
          ),

          const SizedBox(height: Sizes.spaceBtwInputFields),

          // Phone Number
          PhoneInput(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: PhoneValidator.compose(
                [PhoneValidator.required(), PhoneValidator.valid()]),
            showFlagInInput: false,
            initialValue: const PhoneNumber(isoCode: IsoCode.EG, nsn: ''),
            countrySelectorNavigator:
                const CountrySelectorNavigator.draggableBottomSheet(),
            decoration: const InputDecoration(
              hintText: 'Phone Number',
            ),
            onChanged: (value) {
              if (value != null) {
                controller.phoneNumber = '+${value.countryCode}${value.nsn}';
              }
            },
          ),
          const SizedBox(height: Sizes.spaceBtwInputFields),

          // Country, State, and City
          CityPicker(controller: controller),
          const SizedBox(height: Sizes.spaceBtwSections),

          // Terms and Conditions
          const TermsAndConditions(),
          const SizedBox(height: Sizes.spaceBtwSections),

          // Sign Up Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => controller.signUp(),
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: Sizes.buttonHeight / 3),
                child: Text(
                  'Create Account',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
