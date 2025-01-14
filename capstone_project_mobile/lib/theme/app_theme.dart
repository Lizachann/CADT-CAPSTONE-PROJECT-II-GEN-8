import 'package:capstone_project_mobile/theme/base_app_colors.dart';
import 'package:flutter/material.dart';

ThemeData appTheme = ThemeData(
  appBarTheme: AppBarTheme(
    backgroundColor: BaseAppColors.primaryColor,
    titleTextStyle: TextStyle(
      color: BaseAppColors.inversePrimaryColor,
      fontSize: 24,
    ),
    iconTheme: IconThemeData(
      color: BaseAppColors.inversePrimaryColor,
    ),
  ),
  colorScheme: ColorScheme.light(
    primary: BaseAppColors.primaryColor,
    secondary: BaseAppColors.secondaryColor,
    surface: BaseAppColors.surfaceColor,
    tertiary: BaseAppColors.tertiaryColor,
    inversePrimary: BaseAppColors.inversePrimaryColor,
  ),
  textTheme: const TextTheme(
    displayLarge: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 24,
      overflow: TextOverflow.ellipsis,
    ),
    displayMedium: TextStyle(
      overflow: TextOverflow.ellipsis,
      fontWeight: FontWeight.w500,
      fontSize: 20,
    ),
    displaySmall: TextStyle(
      overflow: TextOverflow.ellipsis,
      fontSize: 16,
    ),
    bodyLarge: TextStyle(
      overflow: TextOverflow.ellipsis,
      fontSize: 16,
      height: 1.15,
    ),
    bodyMedium: TextStyle(
      overflow: TextOverflow.ellipsis,
      fontSize: 15,
      height: 1.15,
    ),
    bodySmall: TextStyle(
      overflow: TextOverflow.ellipsis,
      fontSize: 14,
      height: 1.15,
    ),
  ),
);
