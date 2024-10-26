import 'package:flutter/material.dart';

import 'package:fashion_assistant/constants.dart';
import '../theme/widget_themes/appbar_theme.dart';
import '../theme/widget_themes/bottom_sheet_theme.dart';
import '../theme/widget_themes/checkbox_theme.dart';
import '../theme/widget_themes/chip_theme.dart';
import '../theme/widget_themes/elevated_button_theme.dart';
import '../theme/widget_themes/outlined_button_theme.dart';
import '../theme/widget_themes/text_field_theme.dart';
import '../theme/widget_themes/text_theme.dart';


class SAppTheme {
  SAppTheme._();

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Urbanist',
    disabledColor: Colors.grey,
    brightness: Brightness.light,
    primaryColor: OurColors.primaryColor,
    textTheme: STextTheme.lightTextTheme,
    chipTheme: SChipTheme.lightChipTheme,
    scaffoldBackgroundColor: OurColors.primaryBackground,
    appBarTheme: SAppBarTheme.lightAppBarTheme,
    checkboxTheme: SCheckboxTheme.lightCheckboxTheme,
    bottomSheetTheme: SBottomSheetTheme.lightBottomSheetTheme,
    elevatedButtonTheme: SElevatedButtonTheme.lightElevatedButtonTheme,
    outlinedButtonTheme: SOutlinedButtonTheme.lightOutlinedButtonTheme,
    inputDecorationTheme: STextFormFieldTheme.lightInputDecorationTheme,
  );
}
