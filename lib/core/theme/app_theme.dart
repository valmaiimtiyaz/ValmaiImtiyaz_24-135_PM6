import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

class AppTheme {
  static const String fontName = 'Inter';

  //Light Mode
  static ThemeData get lightTheme {
    return ThemeData(
      brightness: Brightness.light,
      scaffoldBackgroundColor: AppColors.champagne,
      primaryColor: AppColors.blazeOrange,
      fontFamily: fontName,
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          color: AppColors.lightNavyBlue,
          fontWeight: FontWeight.w800,
        ),
        headlineMedium: TextStyle(
          color: AppColors.lightNavyBlue,
          fontWeight: FontWeight.bold,
        ),
        titleMedium: TextStyle(
          color: AppColors.coffeeBean,
          fontWeight: FontWeight.w600,
        ),
        bodyLarge: TextStyle(
          color: AppColors.blazeOrange,
          fontWeight: FontWeight.w500,
        ),
        bodyMedium: TextStyle(color: AppColors.coffeeBean),
      ),
      iconTheme: const IconThemeData(color: AppColors.lightNavyBlue),
    );
  }

  //Dark Mode
  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.coffeeBean,
      primaryColor: AppColors.blazeOrange,
      fontFamily: fontName,
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          color: AppColors.champagne,
          fontWeight: FontWeight.w800,
        ),
        headlineMedium: TextStyle(
          color: AppColors.champagne,
          fontWeight: FontWeight.bold,
        ),
        titleMedium: TextStyle(
          color: AppColors.champagne,
          fontWeight: FontWeight.w600,
        ),
        bodyLarge: TextStyle(
          color: AppColors.blazeOrange,
          fontWeight: FontWeight.w500,
        ),
        bodyMedium: TextStyle(color: AppColors.champagne),
      ),
      iconTheme: const IconThemeData(color: AppColors.champagne),
    );
  }
}
