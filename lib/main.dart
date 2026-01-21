import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'features/splash/presentation/screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Используем GoogleFonts для создания текстовой темы
    final textTheme = Theme.of(context).textTheme;
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

    return MaterialApp(
      title: 'MindMapAI',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.indigo,
          background: const Color(0xFFF8F7F5),
        ),
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF8F7F5),
        textTheme: manropeTextTheme,
      ),
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(), // Точка входа теперь - SplashScreen
    );
  }
}
