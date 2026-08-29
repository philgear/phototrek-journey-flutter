import 'package:flutter/material.dart';

class LcarsTheme {
  static const Color backgroundDark = Color(0xFF030712);
  static const Color surfaceDark = Color(0xFF0F172A);
  static const Color surfaceVariant = Color(0xFF1E293B);
  static const Color borderGlass = Color(0x3338BDF8);

  static const Color amberPrimary = Color(0xFFF59E0B);
  static const Color amberGlow = Color(0xFFFBBF24);
  static const Color cyanSecondary = Color(0xFF38BDF8);
  static const Color greenSuccess = Color(0xFF10B981);
  static const Color redAlert = Color(0xFFEF4444);
  static const Color textPrimary = Color(0xFFF8FAFC);
  static const Color textSecondary = Color(0xFF94A3B8);

  static ThemeData get themeData {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: backgroundDark,
      primaryColor: amberPrimary,
      colorScheme: const ColorScheme.dark(
        primary: amberPrimary,
        secondary: cyanSecondary,
        surface: surfaceDark,
        background: backgroundDark,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: surfaceDark,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: TextStyle(
          color: textPrimary,
          fontSize: 18,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.2,
        ),
      ),
    );
  }
}
