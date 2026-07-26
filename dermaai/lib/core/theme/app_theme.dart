import 'package:flutter/material.dart';

class AppTheme {
  // 🎨 Modern Medical AI Color Palette
  static const Color primaryColor = Color(0xFF00A896);      // Deep Electric Teal
  static const Color secondaryColor = Color(0xFF028090);    // Tech Cyan
  static const Color accentColor = Color(0xFFF4A261);       // Soft Amber Accent

  // Light Theme Colors
  static const Color backgroundColorLight = Color(0xFFF8FAFC); // Slate Soft Background
  static const Color surfaceColorLight = Colors.white;
  static const Color surfaceBorderLight = Color(0xFFE2E8F0);

  // Dark Theme Colors
  static const Color backgroundColorDark = Color(0xFF0F172A);  // Deep Slate / Midnight
  static const Color surfaceColorDark = Color(0xFF1E293B);    // Slate Dark Surface
  static const Color surfaceBorderDark = Color(0xFF334155);

  static const Color errorColor = Color(0xFFEF4444);          // Vivid Red

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: const ColorScheme.light(
        primary: primaryColor,
        secondary: secondaryColor,
        tertiary: accentColor,
        background: backgroundColorLight,
        surface: surfaceColorLight,
        error: errorColor,
      ),
      scaffoldBackgroundColor: backgroundColorLight,
      cardTheme: CardThemeData(
        color: surfaceColorLight,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: const BorderSide(color: surfaceBorderLight, width: 1),
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: backgroundColorLight,
        elevation: 0,
        centerTitle: false,
        scrolledUnderElevation: 0,
        iconTheme: IconThemeData(color: Color(0xFF0F172A)),
        titleTextStyle: TextStyle(
          color: Color(0xFF0F172A),
          fontSize: 20,
          fontWeight: FontWeight.w700,
          letterSpacing: -0.3,
        ),
      ),
      textTheme: const TextTheme(
        headlineLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.w800, color: Color(0xFF0F172A), letterSpacing: -0.8),
        headlineMedium: TextStyle(fontSize: 24, fontWeight: FontWeight.w700, color: Color(0xFF0F172A), letterSpacing: -0.5),
        titleLarge: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Color(0xFF0F172A), letterSpacing: -0.2),
        bodyLarge: TextStyle(fontSize: 16, color: Color(0xFF334155), height: 1.5),
        bodyMedium: TextStyle(fontSize: 14, color: Color(0xFF64748B), height: 1.4),
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: const ColorScheme.dark(
        primary: primaryColor,
        secondary: secondaryColor,
        tertiary: accentColor,
        background: backgroundColorDark,
        surface: surfaceColorDark,
        error: errorColor,
      ),
      scaffoldBackgroundColor: backgroundColorDark,
      cardTheme: CardThemeData(
        color: surfaceColorDark,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: const BorderSide(color: surfaceBorderDark, width: 1),
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: backgroundColorDark,
        elevation: 0,
        centerTitle: false,
        scrolledUnderElevation: 0,
        iconTheme: IconThemeData(color: Colors.white),
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.w700,
          letterSpacing: -0.3,
        ),
      ),
      textTheme: const TextTheme(
        headlineLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.w800, color: Colors.white, letterSpacing: -0.8),
        headlineMedium: TextStyle(fontSize: 24, fontWeight: FontWeight.w700, color: Colors.white, letterSpacing: -0.5),
        titleLarge: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.white, letterSpacing: -0.2),
        bodyLarge: TextStyle(fontSize: 16, color: Color(0xFFCBD5E1), height: 1.5),
        bodyMedium: TextStyle(fontSize: 14, color: Color(0xFF94A3B8), height: 1.4),
      ),
    );
  }
}