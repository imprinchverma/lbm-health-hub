import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  static const background = Color(0xFF000000);
  static const surface = Color(0xFF141414);
  static const surfaceElevated = Color(0xFF1C1C1E);
  static const card = Color(0xFF1A1A1A);
  static const border = Color(0xFF2A2A2A);

  static const textPrimary = Color(0xFFFFFFFF);
  static const textSecondary = Color(0xFFB0B0B0);
  static const textMuted = Color(0xFF7A7A7A);

  static const neonGreen = Color(0xFF39FF14);
  static const softGreen = Color(0xFF7CFF6B);
  static const cyan = Color(0xFF00E5FF);
  static const electricBlue = Color(0xFF2F6BFF);
  static const gold = Color(0xFFE8B923);
  static const amber = Color(0xFFFFC107);
  static const orange = Color(0xFFFF8A3D);
  static const red = Color(0xFFFF3B3B);
  static const softRed = Color(0xFFFF6B6B);
  static const pink = Color(0xFFFF5C8A);

  static const gaugeVeryLow = Color(0xFFE53935);
  static const gaugeLow = Color(0xFFFF7043);
  static const gaugeModerate = Color(0xFFFFCA28);
  static const gaugeOptimal = Color(0xFFC6FF00);
  static const gaugeHigh = Color(0xFF66BB6A);
  static const gaugeVeryHigh = Color(0xFF2E7D32);

  static const holographic = Color(0xFF1E90FF);
}

class AppTheme {
  static ThemeData get dark {
    final base = ThemeData.dark(useMaterial3: true);
    final display = GoogleFonts.michromaTextTheme(base.textTheme);
    final body = GoogleFonts.interTextTheme(base.textTheme);

    return base.copyWith(
      scaffoldBackgroundColor: AppColors.background,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.neonGreen,
        secondary: AppColors.cyan,
        surface: AppColors.surface,
        error: AppColors.red,
      ),
      textTheme: body.copyWith(
        displayLarge: display.displayLarge?.copyWith(
          color: AppColors.textPrimary,
          fontWeight: FontWeight.w400,
          letterSpacing: 1.2,
        ),
        displayMedium: display.displayMedium?.copyWith(
          color: AppColors.textPrimary,
          letterSpacing: 1.1,
        ),
        headlineLarge: display.headlineLarge?.copyWith(
          color: AppColors.textPrimary,
          fontSize: 22,
          letterSpacing: 1.5,
        ),
        headlineMedium: display.headlineMedium?.copyWith(
          color: AppColors.textPrimary,
          fontSize: 18,
          letterSpacing: 1.2,
        ),
        headlineSmall: display.headlineSmall?.copyWith(
          color: AppColors.textPrimary,
          fontSize: 16,
          letterSpacing: 1.0,
        ),
        titleLarge: display.titleLarge?.copyWith(
          color: AppColors.textPrimary,
          fontSize: 15,
          letterSpacing: 1.4,
        ),
        titleMedium: body.titleMedium?.copyWith(
          color: AppColors.textPrimary,
          fontWeight: FontWeight.w600,
        ),
        bodyLarge: body.bodyLarge?.copyWith(color: AppColors.textPrimary),
        bodyMedium: body.bodyMedium?.copyWith(color: AppColors.textSecondary),
        bodySmall: body.bodySmall?.copyWith(color: AppColors.textMuted),
        labelLarge: display.labelLarge?.copyWith(
          color: AppColors.textPrimary,
          letterSpacing: 1.2,
        ),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: display.titleLarge?.copyWith(
          color: AppColors.textPrimary,
          fontSize: 18,
          letterSpacing: 2,
        ),
        iconTheme: const IconThemeData(color: AppColors.textPrimary),
      ),
    );
  }
}
