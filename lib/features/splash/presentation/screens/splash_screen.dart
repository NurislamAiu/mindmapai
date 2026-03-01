import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    _controller.forward();

    Timer(const Duration(milliseconds: 2800), () {
      if (mounted) {
        // Используем GoRouter для навигации
        context.go('/onboarding');
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
      systemNavigationBarColor: Colors.transparent,
      statusBarColor: Colors.transparent,
    ));

    return Scaffold(
      backgroundColor: const Color(0xFFF8F7F5),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FadeTransition(
              opacity: CurvedAnimation(parent: _controller, curve: Curves.easeIn),
              child: ScaleTransition(
                scale: CurvedAnimation(parent: _controller, curve: Curves.easeOutQuart),
                child: Image.asset(
                  'assets/icon/icon.png',
                  width: 120,
                  height: 120,
                ),
              ),
            ),
            FadeTransition(
              opacity: CurvedAnimation(
                parent: _controller,
                curve: const Interval(0.4, 1.0, curve: Curves.easeOut),
              ),
              child: Text(
                'MINDRA',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontFamily: 'Manrope',
                      color: Colors.black,
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 8,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
