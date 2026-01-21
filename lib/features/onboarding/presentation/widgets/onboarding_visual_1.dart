import 'dart:ui';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class OnboardingVisual1 extends StatefulWidget {
  final bool isVisible;
  const OnboardingVisual1({super.key, required this.isVisible});

  @override
  State<OnboardingVisual1> createState() => _OnboardingVisual1State();
}

class _OnboardingVisual1State extends State<OnboardingVisual1>
    with TickerProviderStateMixin {
  late final AnimationController _entryController;
  late final AnimationController _pulseController;
  late final AnimationController _rotationController;

  @override
  void initState() {
    super.initState();
    _entryController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 4000),
    )..repeat();
    
    _rotationController = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 10000),
    )..repeat();

    if (widget.isVisible) {
      _entryController.forward();
    }
  }

  @override
  void didUpdateWidget(covariant OnboardingVisual1 oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isVisible && !oldWidget.isVisible) {
      _entryController.forward(from: 0.0);
      _pulseController.repeat();
      _rotationController.repeat();
    } else if (!widget.isVisible && oldWidget.isVisible) {
      _entryController.reset();
      _pulseController.stop();
      _rotationController.stop();
    }
  }

  @override
  void dispose() {
    _entryController.dispose();
    _pulseController.dispose();
    _rotationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([_entryController, _pulseController, _rotationController]),
      builder: (context, child) {
        final entryProgress = Curves.elasticOut.transform(_entryController.value);
        return Transform.scale(
          scale: entryProgress,
          child: CustomPaint(
            painter: _GlowingOrbPainter(
              _pulseController.value,
              _rotationController.value
            ),
            size: const Size(200, 200),
          ),
        );
      },
    );
  }
}

class _GlowingOrbPainter extends CustomPainter {
  final double pulseProgress;
  final double rotationProgress;
  _GlowingOrbPainter(this.pulseProgress, this.rotationProgress);

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final color = Colors.indigo[500]!;

    // Create a sinusoidal pulse for a more natural breathing effect
    final pulse = math.sin(pulseProgress * 2 * math.pi); // Varies between -1 and 1
    final positivePulse = (pulse + 1) / 2; // Remap to 0-1

    // Paints
    final dotPaint = Paint()..color = color;
    final glowPaint = Paint();
    final particlePaint = Paint()..color = Colors.indigo[100]!;

    // Outer Glow - subtle and wide
    glowPaint
      ..color = color.withOpacity(0.1 + 0.05 * positivePulse)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 80.0);
    canvas.drawCircle(center, size.width * 0.45, glowPaint);

    // Mid Glow - more focused
    glowPaint
      ..color = color.withOpacity(0.2 + 0.1 * positivePulse)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 40.0);
    canvas.drawCircle(center, size.width * 0.3, glowPaint);
    
    // Inner Glow / Halo
    glowPaint
      ..color = color.withOpacity(0.5)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 20.0);
    canvas.drawCircle(center, size.width * 0.05 + 4 * positivePulse, glowPaint);
    
    // Central Orb
    final orbRadius = size.width * 0.04 + 2 * positivePulse;
    canvas.drawCircle(center, orbRadius, dotPaint);

    // Orbiting Particles
    void drawParticle(double angleOffset, double radius, double size) {
        final angle = rotationProgress * 2 * math.pi + angleOffset;
        final particleCenter = Offset(
            center.dx + radius * math.cos(angle),
            center.dy + radius * math.sin(angle)
        );
        canvas.drawCircle(particleCenter, size, particlePaint);
    }
    
    drawParticle(0, orbRadius + 20, 1.5);
    drawParticle(math.pi * 1.2, orbRadius + 45, 1.0);
  }

  @override
  bool shouldRepaint(covariant _GlowingOrbPainter oldDelegate) {
    return pulseProgress != oldDelegate.pulseProgress || rotationProgress != oldDelegate.rotationProgress;
  }
}
