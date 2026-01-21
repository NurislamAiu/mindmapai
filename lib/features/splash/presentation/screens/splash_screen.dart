import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import '../../../onboarding/presentation/screens/onboarding_screen.dart';
import 'dart:math' as math;

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

    // Navigate after a delay
    Timer(const Duration(milliseconds: 1800), () {
      if (mounted) {
        Navigator.of(context).pushReplacement(
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                const OnboardingScreen(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return FadeTransition(opacity: animation, child: child);
            },
            transitionDuration: const Duration(milliseconds: 800),
          ),
        );
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
    // Set system UI to be subtle
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
            // Logo
            FadeTransition(
              opacity: CurvedAnimation(parent: _controller, curve: Curves.easeIn),
              child: ScaleTransition(
                scale: CurvedAnimation(parent: _controller, curve: Curves.easeOutQuart),
                child: AnimatedBuilder(
                  animation: _controller,
                  builder: (context, child) {
                    return CustomPaint(
                      painter: _LogoPainter(_controller.value),
                      size: const Size(120, 120),
                    );
                  },
                ),
              ),
            ),
            // App Name
            const SizedBox(height: 24),
            FadeTransition(
              opacity: CurvedAnimation(
                parent: _controller,
                curve: const Interval(0.4, 1.0, curve: Curves.easeOut),
              ),
              child: Text(
                'MindMapAI',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Colors.grey[700],
                      fontWeight: FontWeight.w300,
                      letterSpacing: 4,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LogoPainter extends CustomPainter {
  final double progress;
  _LogoPainter(this.progress);

  double _getAnimValue(double start, double duration) {
    return Curves.easeInOut.transform(
      ((progress - start) / duration).clamp(0.0, 1.0),
    );
  }

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final mainColor = Colors.indigo[600]!;
    final secondaryColor = Colors.indigo[400]!;
    final tertiaryColor = Colors.indigo[300]!;

    // Node Positions
    final centerNode = (pos: center, radius: 6.0);
    final secondaryNodes = List.generate(4, (i) {
      final angle = (i * 90.0) * (math.pi / 180);
      return (
        pos: Offset(center.dx + 30 * math.cos(angle), center.dy + 30 * math.sin(angle)),
        radius: 4.0,
      );
    });
    final tertiaryNodes = List.generate(8, (i) {
      final parentIndex = i ~/ 2;
      final angle = (parentIndex * 90.0 + (i % 2 == 0 ? -20 : 20)) * (math.pi / 180);
      return (
        pos: Offset(center.dx + 45 * math.cos(angle), center.dy + 45 * math.sin(angle)),
        radius: 2.5,
      );
    });

    // Paints
    final linePaint = (Color color, double stroke) => Paint()
      ..color = color
      ..strokeWidth = stroke
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;
    final nodePaint = Paint();

    // --- Draw Glow ---
    final glowProgress = _getAnimValue(0.0, 0.5);
    if (glowProgress > 0) {
      final glowPaint = Paint()
        ..shader = RadialGradient(
          colors: [
            mainColor.withOpacity(0.15 * glowProgress),
            mainColor.withOpacity(0.0),
          ],
        ).createShader(Rect.fromCircle(center: center, radius: size.width * 0.4));
      canvas.drawCircle(center, size.width * 0.4, glowPaint);
    }
    
    // --- Draw Primary Connections & Center Node ---
    final primaryProgress = _getAnimValue(0.1, 0.4);
    for (var node in secondaryNodes) {
        final currentEnd = Offset.lerp(center, node.pos, primaryProgress)!;
        canvas.drawLine(center, currentEnd, linePaint(mainColor, 1.5));
    }
    nodePaint.color = mainColor;
    canvas.drawCircle(center, centerNode.radius, nodePaint);

    // --- Draw Secondary Connections & Nodes ---
    final secondaryProgress = _getAnimValue(0.3, 0.5);
    for (int i = 0; i < tertiaryNodes.length; i++) {
        final parentPos = secondaryNodes[i ~/ 2].pos;
        final currentEnd = Offset.lerp(parentPos, tertiaryNodes[i].pos, secondaryProgress)!;
        canvas.drawLine(parentPos, currentEnd, linePaint(secondaryColor, 1.0));
    }
    for (var node in secondaryNodes) {
        nodePaint.color = secondaryColor;
        canvas.drawCircle(node.pos, node.radius * primaryProgress, nodePaint);
    }

    // --- Draw Tertiary Nodes ---
    final tertiaryProgress = _getAnimValue(0.5, 0.5);
    if (tertiaryProgress > 0) {
        for (var node in tertiaryNodes) {
            nodePaint.color = tertiaryColor;
            canvas.drawCircle(node.pos, node.radius * tertiaryProgress, nodePaint);
        }
    }
  }

  @override
  bool shouldRepaint(_LogoPainter oldDelegate) {
    return progress != oldDelegate.progress;
  }
}
