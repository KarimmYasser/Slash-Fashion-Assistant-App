import 'package:flutter/material.dart';
import '../../../constants.dart';

class SChipTheme {
  SChipTheme._();

  static ChipThemeData lightChipTheme = ChipThemeData(
    checkmarkColor: Colors.white,
    selectedColor: OurColors.primaryColor,
    disabledColor: Colors.grey.withOpacity(0.4),
    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12),
    labelStyle: const TextStyle(color: Colors.black, fontFamily: 'Urbanist'),
  );

  static ChipThemeData darkChipTheme = const ChipThemeData(
    checkmarkColor: Colors.white,
    selectedColor: OurColors.primaryColor,
    disabledColor: OurColors.darkerGrey,
    padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 12),
    labelStyle: TextStyle(color: Colors.white, fontFamily: 'Urbanist'),
  );
}
