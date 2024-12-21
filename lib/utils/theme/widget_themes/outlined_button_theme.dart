import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../constants.dart';

/* -- Light & Dark Outlined Button Themes -- */
class SOutlinedButtonTheme {
  SOutlinedButtonTheme._(); //To avoid creating instances


  /* -- Light Theme -- */
  static final lightOutlinedButtonTheme  = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      elevation: 0,
      foregroundColor: OurColors.dark,
      side: const BorderSide(color: OurColors.borderPrimary),
      padding: const EdgeInsets.symmetric(vertical: Sizes.buttonHeight, horizontal: 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Sizes.buttonRadius)),
      textStyle: TextStyle(fontSize: 16, color: OurColors.black, fontWeight: FontWeight.w600, fontFamily: GoogleFonts.urbanist().fontFamily),
    ),
  );

  /* -- Dark Theme -- */
  static final darkOutlinedButtonTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: OurColors.light,
      side: const BorderSide(color: OurColors.borderPrimary),
      padding: const EdgeInsets.symmetric(vertical: Sizes.buttonHeight, horizontal: 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Sizes.buttonRadius)),
      textStyle: TextStyle(fontSize: 16, color: OurColors.textWhite, fontWeight: FontWeight.w600, fontFamily: GoogleFonts.urbanist().fontFamily),
    ),
  );
}
