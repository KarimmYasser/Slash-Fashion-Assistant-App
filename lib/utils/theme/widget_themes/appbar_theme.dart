import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../constants.dart';

class SAppBarTheme{
  SAppBarTheme._();

  static final lightAppBarTheme = AppBarTheme(
    elevation: 0,
    centerTitle: false,
    scrolledUnderElevation: 0,
    backgroundColor: Colors.white,
    surfaceTintColor: Colors.white,
    iconTheme: const IconThemeData(color: OurColors.iconPrimary, size: Sizes.iconMd),
    actionsIconTheme: const IconThemeData(color: OurColors.iconPrimary, size: Sizes.iconMd),
    titleTextStyle: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600, color: Colors.black, fontFamily: GoogleFonts.urbanist().fontFamily),
  );
  static final darkAppBarTheme = AppBarTheme(
    elevation: 0,
    centerTitle: false,
    scrolledUnderElevation: 0,
    backgroundColor: OurColors.dark,
    surfaceTintColor: OurColors.dark,
    iconTheme: const IconThemeData(color: Colors.black, size: Sizes.iconMd),
    actionsIconTheme: const IconThemeData(color: Colors.white, size: Sizes.iconMd),
    titleTextStyle: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600, color: Colors.white, fontFamily: GoogleFonts.urbanist().fontFamily),
  );
}