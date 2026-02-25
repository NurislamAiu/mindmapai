import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData get light {
    final textTheme = ThemeData.light().textTheme;
    final manropeTextTheme = GoogleFonts.manropeTextTheme(textTheme).copyWith(
      headlineMedium: GoogleFonts.manrope(
        fontSize: 28,
        fontWeight: FontWeight.bold,
        color: const Color(0xFF1E1E2F),
      ),
      bodyLarge: GoogleFonts.manrope(
        fontSize: 16,
        color: Colors.black54,
        height: 1.5,
      ),
    );

    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.indigo,
        background: const Color(0xFFF8F7F5),
      ),
      useMaterial3: true,
      scaffoldBackgroundColor: const Color(0xFFF8F7F5),
      textTheme: manropeTextTheme,
    );
  }
}
