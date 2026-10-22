import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/app_colors.dart';

ThemeData get darkTheme {
  return ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: const ColorScheme.dark(
      primary: AppColors.primaryGreenDark,
      onPrimary: AppColors.backgroundDark,
      secondary: AppColors.primaryYellowDark,
      surface: AppColors.surfaceDark,
      onSurface: AppColors.onSurfaceDark,
      error: AppColors.error,
    ),
    scaffoldBackgroundColor: AppColors.backgroundDark,
    textTheme: GoogleFonts.poppinsTextTheme(ThemeData.dark().textTheme),
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.surfaceDark,
      foregroundColor: AppColors.onSurfaceDark,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: GoogleFonts.poppins(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: AppColors.onSurfaceDark,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryGreenDark,
        foregroundColor: AppColors.backgroundDark,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    ),
    cardTheme: CardThemeData(
      color: AppColors.surfaceElevatedDark,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColors.primaryGreenDark,
      foregroundColor: AppColors.backgroundDark,
    ),
  );
}
