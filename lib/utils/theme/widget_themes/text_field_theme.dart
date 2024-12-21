import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../constants.dart';

class STextFormFieldTheme {
  STextFormFieldTheme._();

  static InputDecorationTheme lightInputDecorationTheme = InputDecorationTheme(
    errorMaxLines: 3,
    prefixIconColor: OurColors.darkGrey,
    suffixIconColor: OurColors.darkGrey,
    // constraints: const BoxConstraints.expand(height: Sizes.inputFieldHeight),
    labelStyle: const TextStyle().copyWith(fontSize: Sizes.fontSizeMd, color: OurColors.textPrimary, fontFamily: GoogleFonts.urbanist().fontFamily),
    hintStyle: const TextStyle().copyWith(fontSize: Sizes.fontSizeSm, color: OurColors.textSecondary, fontFamily: GoogleFonts.urbanist().fontFamily),
    errorStyle: const TextStyle().copyWith(fontStyle: FontStyle.normal, fontFamily: GoogleFonts.urbanist().fontFamily),
    floatingLabelStyle: const TextStyle().copyWith(color: OurColors.textSecondary, fontFamily: GoogleFonts.urbanist().fontFamily),
    border: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(Sizes.inputFieldRadius),
      borderSide: const BorderSide(width: 1, color: OurColors.borderPrimary),
    ),
    enabledBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(Sizes.inputFieldRadius),
      borderSide: const BorderSide(width: 1, color: OurColors.borderPrimary),
    ),
    focusedBorder:const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(Sizes.inputFieldRadius),
      borderSide: const BorderSide(width: 1, color: OurColors.borderSecondary),
    ),
    errorBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(Sizes.inputFieldRadius),
      borderSide: const BorderSide(width: 1, color: OurColors.errorColor),
    ),
    focusedErrorBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(Sizes.inputFieldRadius),
      borderSide: const BorderSide(width: 2, color: OurColors.errorColor),
    ),
  );

  static InputDecorationTheme darkInputDecorationTheme = InputDecorationTheme(
    errorMaxLines: 2,
    prefixIconColor: OurColors.darkGrey,
    suffixIconColor: OurColors.darkGrey,
    // constraints: const BoxConstraints.expand(height: Sizes.inputFieldHeight),
    labelStyle: const TextStyle().copyWith(fontSize: Sizes.fontSizeMd, color: OurColors.white, fontFamily: GoogleFonts.urbanist().fontFamily),
    hintStyle: const TextStyle().copyWith(fontSize: Sizes.fontSizeSm, color: OurColors.white, fontFamily: GoogleFonts.urbanist().fontFamily),
    floatingLabelStyle: const TextStyle().copyWith(color: OurColors.white.withOpacity(0.8), fontFamily: GoogleFonts.urbanist().fontFamily),
    border: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(Sizes.inputFieldRadius),
      borderSide: const BorderSide(width: 1, color: OurColors.darkGrey),
    ),
    enabledBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(Sizes.inputFieldRadius),
      borderSide: const BorderSide(width: 1, color: OurColors.darkGrey),
    ),
    focusedBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(Sizes.inputFieldRadius),
      borderSide: const BorderSide(width: 1, color: OurColors.white),
    ),
    errorBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(Sizes.inputFieldRadius),
      borderSide: const BorderSide(width: 1, color: OurColors.errorColor),
    ),
    focusedErrorBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(Sizes.inputFieldRadius),
      borderSide: const BorderSide(width: 2, color: OurColors.errorColor),
    ),
  );
}
