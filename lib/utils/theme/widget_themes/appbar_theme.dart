import 'package:flutter/material.dart';
import '../../../constants.dart';

class SAppBarTheme{
  SAppBarTheme._();

  static const lightAppBarTheme = AppBarTheme(
    elevation: 0,
    centerTitle: false,
    scrolledUnderElevation: 0,
    backgroundColor: Colors.white,
    surfaceTintColor: Colors.white,
    iconTheme: IconThemeData(color: OurColors.iconPrimary, size: Sizes.iconMd),
    actionsIconTheme: IconThemeData(color: OurColors.iconPrimary, size: Sizes.iconMd),
    titleTextStyle: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600, color: Colors.black, fontFamily: 'Urbanist'),
  );
  static const darkAppBarTheme = AppBarTheme(
    elevation: 0,
    centerTitle: false,
    scrolledUnderElevation: 0,
    backgroundColor: OurColors.dark,
    surfaceTintColor: OurColors.dark,
    iconTheme: IconThemeData(color: Colors.black, size: Sizes.iconMd),
    actionsIconTheme: IconThemeData(color: Colors.white, size: Sizes.iconMd),
    titleTextStyle: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600, color: Colors.white, fontFamily: 'Urbanist'),
  );
}