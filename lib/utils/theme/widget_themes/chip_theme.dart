import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../constants.dart';

class SChipTheme {
  SChipTheme._();

  static ChipThemeData lightChipTheme = ChipThemeData(
    checkmarkColor: Colors.white,
    selectedColor: OurColors.primaryColor,
    disabledColor: Colors.grey.withOpacity(0.4),
    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12),
    labelStyle: TextStyle(color: Colors.black, fontFamily: GoogleFonts.urbanist().fontFamily),
  );

  static ChipThemeData darkChipTheme = ChipThemeData(
    checkmarkColor: Colors.white,
    selectedColor: OurColors.primaryColor,
    disabledColor: OurColors.darkerGrey,
    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12),
    labelStyle: TextStyle(color: Colors.white, fontFamily: GoogleFonts.urbanist().fontFamily),
  );
}
