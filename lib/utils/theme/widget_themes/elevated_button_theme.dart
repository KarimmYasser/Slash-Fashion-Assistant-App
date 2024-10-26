import 'package:flutter/material.dart';
import '../../../constants.dart';

/* -- Light & Dark Elevated Button Themes -- */
class SElevatedButtonTheme {
  SElevatedButtonTheme._(); //To avoid creating instances

  /* -- Light Theme -- */
  static final lightElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      foregroundColor: OurColors.light,
      backgroundColor: OurColors.primaryColor,
      disabledForegroundColor: OurColors.darkGrey,
      disabledBackgroundColor: OurColors.buttonDisabled,
      side: const BorderSide(color: OurColors.primaryColor),
      padding: const EdgeInsets.symmetric(vertical: Sizes.buttonHeight),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Sizes.buttonRadius)),
      textStyle: const TextStyle(
          fontSize: 16,
          color: OurColors.textWhite,
          fontWeight: FontWeight.w500,
          fontFamily: 'Urbanist'),
    ),
  );

  /* -- Dark Theme -- */
  static final darkElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      foregroundColor: OurColors.light,
      backgroundColor: OurColors.primaryColor,
      disabledForegroundColor: OurColors.darkGrey,
      disabledBackgroundColor: OurColors.darkerGrey,
      side: const BorderSide(color: OurColors.primaryColor),
      padding: const EdgeInsets.symmetric(vertical: Sizes.buttonHeight),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Sizes.buttonRadius)),
      textStyle: const TextStyle(
          fontSize: 16,
          color: OurColors.textWhite,
          fontWeight: FontWeight.w600,
          fontFamily: 'Urbanist'),
    ),
  );
}
