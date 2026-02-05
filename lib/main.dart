import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'config/router/app_router.dart';

void main() async {
  // Убеждаемся, что все биндинги Flutter инициализированы.
  // Это ОБЯЗАТЕЛЬНО для асинхронного main и будущей инициализации Firebase.
  WidgetsFlutterBinding.ensureInitialized();
  
  // Здесь в будущем будет инициализация Firebase, API, DI-контейнеров и т.д.
  // await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
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

    // Меняем MaterialApp на MaterialApp.router
    return MaterialApp.router(
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
      // Передаем конфигурацию роутера
      routerConfig: appRouter,
    );
  }
}
