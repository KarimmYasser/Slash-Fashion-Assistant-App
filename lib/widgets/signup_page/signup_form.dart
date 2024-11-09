import 'package:csc_picker/csc_picker.dart';
import 'package:fashion_assistant/utils/helpers/validation.dart';
import 'package:get/get.dart';
import 'package:phone_input/phone_input_package.dart';

import '../../constants.dart';
import '../../screens/authentication/controllers/signup_controller.dart';
import '../../screens/authentication/terms_conditons.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

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
          FormField<String>(
            validator: (value) {
              if (controller.countryValue == null ||
                  controller.stateValue == null ||
                  controller.cityValue == null) {
                return 'Please select your country, state, and city.';
              }
              return null;
            },
            builder: (FormFieldState<String> state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CSCPicker(
                    showStates: true,
                    showCities: true,
                    flagState: CountryFlag.ENABLE,
                    dropdownDecoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(
                            Radius.circular(Sizes.borderRadiusMd)),
                        color: OurColors.white,
                        border: Border.all(color: OurColors.grey, width: 1)),
                    disabledDropdownDecoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(
                            Radius.circular(Sizes.borderRadiusMd)),
                        color: OurColors.grey,
                        border: Border.all(color: OurColors.grey, width: 1)),
                    countrySearchPlaceholder: "Country",
                    stateSearchPlaceholder: "State",
                    citySearchPlaceholder: "City",
                    countryDropdownLabel: "Country",
                    stateDropdownLabel: "State",
                    cityDropdownLabel: "City",
                    countryFilter: const [
                      CscCountry.Egypt,
                      CscCountry.Saudi_Arabia
                    ],
                    dropdownHeadingStyle:
                        Theme.of(context).textTheme.headlineSmall,
                    dropdownDialogRadius: Sizes.dropdownDialogRadius,
                    searchBarRadius: Sizes.searchBarRadius,
                    onCountryChanged: (value) =>
                        controller.countryValue = value,
                    onStateChanged: (value) => controller.stateValue = value,
                    onCityChanged: (value) => controller.cityValue = value,
                  ),
                  if (state.hasError)
                    Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: Text(
                        state.errorText ?? '',
                        style: const TextStyle(
                          color: OurColors.errorTextColor,
                          fontSize: 14.0,
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
          const SizedBox(height: Sizes.spaceBtwSections),
          const TermsAndConditions(),
          const SizedBox(height: Sizes.spaceBtwSections),
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
