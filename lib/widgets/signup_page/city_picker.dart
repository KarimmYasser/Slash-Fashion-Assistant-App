import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';
import '../../screens/authentication/controllers/signup_controller.dart';

class CityPicker extends StatelessWidget {
  const CityPicker({
    super.key,
    required this.controller,
  });

  final SignupController controller;

  @override
  Widget build(BuildContext context) {
    return FormField<String>(
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
    );
  }
}
