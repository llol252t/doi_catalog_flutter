import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTheme {
  AppTheme._();

  static ThemeData light() {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: AppColors.lightPrimary,
      brightness: Brightness.light,
    );
    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: colorScheme.surface,
      textTheme: _textTheme(Colors.black87),
    );
  }

  static ThemeData dark() {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: AppColors.darkPrimary,
      brightness: Brightness.dark,
    );
    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: colorScheme.surface,
      textTheme: _textTheme(Colors.white),
    );
  }

  static TextTheme _textTheme(Color color) {
    return TextTheme(
      titleMedium: TextStyle(color: color, fontSize: 16, fontWeight: FontWeight.w500),
      bodySmall: TextStyle(color: color, fontSize: 12),
      labelMedium: TextStyle(color: color, fontSize: 12),
      headlineSmall: TextStyle(color: color, fontSize: 24, fontWeight: FontWeight.w600),
      labelSmall: TextStyle(color: color, fontSize: 11),
      bodyMedium: TextStyle(color: color, fontSize: 14),
    );
  }
}
// import 'package:flutter/material.dart';
// import 'app_colors.dart';

// class AppTheme {
//   AppTheme._();

//   static ThemeData light() {
//     return ThemeData(
//       useMaterial3: true,
//       brightness: Brightness.light,
//       colorScheme: const ColorScheme.light(
//         primary: AppColors.lightPrimary,
//         secondary: AppColors.lightSecondary,
//         surface: AppColors.lightSurface,
//       ),
//       scaffoldBackgroundColor: AppColors.lightBackground,
//     );
//   }

//   static ThemeData dark() {
//     return ThemeData(
//       useMaterial3: true,
//       brightness: Brightness.dark,
//       colorScheme: const ColorScheme.dark(
//         primary: AppColors.darkPrimary,
//         secondary: AppColors.darkSecondary,
//         surface: AppColors.darkSurface,
//       ),
//       scaffoldBackgroundColor: AppColors.darkBackground,
//     );
//   }
// }