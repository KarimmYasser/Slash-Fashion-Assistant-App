import 'package:flutter/material.dart';
import '../../../constants.dart';

/// Custom Class for Light & Dark Text Themes
class STextTheme {
  STextTheme._(); // To avoid creating instances

  /// Customizable Light Text Theme
  static TextTheme lightTextTheme = TextTheme(
    headlineLarge: const TextStyle().copyWith(fontSize: 24.0, fontWeight: FontWeight.bold, color: OurColors.textPrimary),
    headlineMedium: const TextStyle().copyWith(fontSize: 18.0, fontWeight: FontWeight.bold, color: OurColors.textPrimary),
    headlineSmall: const TextStyle().copyWith(fontSize: 16.0, fontWeight: FontWeight.bold, color: OurColors.textPrimary),

    titleLarge: const TextStyle().copyWith(fontSize: 16.0, fontWeight: FontWeight.w600, color: OurColors.textPrimary),
    titleMedium: const TextStyle().copyWith(fontSize: 16.0, fontWeight: FontWeight.w600, color: OurColors.textPrimary),
    titleSmall: const TextStyle().copyWith(fontSize: 16.0, fontWeight: FontWeight.w400, color: OurColors.textSecondary),

    bodyLarge: const TextStyle().copyWith(fontSize: 14.0, fontWeight: FontWeight.w600, color: OurColors.textPrimary),
    bodyMedium: const TextStyle().copyWith(fontSize: 14.0, fontWeight: FontWeight.normal, color: OurColors.textPrimary),
    bodySmall: const TextStyle().copyWith(fontSize: 14.0, fontWeight: FontWeight.normal, color: OurColors.textSecondary),

    labelLarge: const TextStyle().copyWith(fontSize: 12.0, fontWeight: FontWeight.normal, color: OurColors.textPrimary),
    labelMedium: const TextStyle().copyWith(fontSize: 12.0, fontWeight: FontWeight.normal, color: OurColors.textSecondary),
  );

  /// Customizable Dark Text Theme
  static TextTheme darkTextTheme = TextTheme(
    headlineLarge: const TextStyle().copyWith(fontSize: 24.0, fontWeight: FontWeight.bold, color: OurColors.light),
    headlineMedium: const TextStyle().copyWith(fontSize: 18.0, fontWeight: FontWeight.bold, color: OurColors.light),
    headlineSmall: const TextStyle().copyWith(fontSize: 16.0, fontWeight: FontWeight.w600, color: OurColors.light),

    titleLarge: const TextStyle().copyWith(fontSize: 16.0, fontWeight: FontWeight.bold, color: OurColors.light),
    titleMedium: const TextStyle().copyWith(fontSize: 16.0, fontWeight: FontWeight.w600, color: OurColors.light),
    titleSmall: const TextStyle().copyWith(fontSize: 16.0, fontWeight: FontWeight.w400, color: OurColors.light),

    bodyLarge: const TextStyle().copyWith(fontSize: 14.0, fontWeight: FontWeight.w600, color: OurColors.light),
    bodyMedium: const TextStyle().copyWith(fontSize: 14.0, fontWeight: FontWeight.normal, color: OurColors.light),
    bodySmall: const TextStyle().copyWith(fontSize: 14.0, fontWeight: FontWeight.w400, color: OurColors.light.withOpacity(0.5)),

    labelLarge: const TextStyle().copyWith(fontSize: 12.0, fontWeight: FontWeight.normal, color: OurColors.light),
    labelMedium: const TextStyle().copyWith(fontSize: 12.0, fontWeight: FontWeight.normal, color: OurColors.light.withOpacity(0.5)),
  );
}
