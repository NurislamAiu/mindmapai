import 'dart:ui';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class OnboardingVisual2 extends StatefulWidget {
  final bool isVisible;
  const OnboardingVisual2({super.key, required this.isVisible});

  @override
  State<OnboardingVisual2> createState() => _OnboardingVisual2State();
}

class _OnboardingVisual2State extends State<OnboardingVisual2>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2200),
    );

    if (widget.isVisible) {
      _controller.forward();
    }
  }

  @override
  void didUpdateWidget(covariant OnboardingVisual2 oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isVisible && !oldWidget.isVisible) {
      _controller.forward(from: 0.0);
    } else if (!widget.isVisible && oldWidget.isVisible) {
      _controller.reset();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          painter: _DynamicMindMapPainter(_controller.value),
          size: const Size(280, 280),
        );
      },
    );
  }
}

class _DynamicMindMapPainter extends CustomPainter {
  final double progress;
  _DynamicMindMapPainter(this.progress);

  // Helper to create staggered animations with custom curves
  double _getAnimValue(double start, double duration, Curve curve) {
    return curve.transform(((progress - start) / duration).clamp(0.0, 1.0));
  }

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final mainNodeColor = Colors.indigo[600]!;
    final subNodeColor = Colors.indigo[400]!;
    final lineColor = Colors.indigo[400]!.withOpacity(0.5);

    final linePaint = Paint()
      ..color = lineColor
      ..strokeWidth = 2.0
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    final nodePaint = Paint()..style = PaintingStyle.fill;

    // --- Node Positions ---
    final centerNodeRadius = 16.0;
    final outerNodeRadius = 10.0;
    final outerNodesPositions = [
      Offset(size.width * 0.21, size.height * 0.28),
      Offset(size.width * 0.78, size.height * 0.25),
      Offset(size.width * 0.18, size.height * 0.68),
      Offset(size.width * 0.82, size.height * 0.66),
      Offset(size.width * 0.5, size.height * 0.78),
    ];

    // --- Draw Central Node ---
    final centerNodeProgress = _getAnimValue(0.0, 0.2, Curves.elasticOut);
    if (centerNodeProgress > 0) {
      final glowPaint = Paint()
        ..color = mainNodeColor.withOpacity(0.3 * centerNodeProgress)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 25.0);
      canvas.drawCircle(center, centerNodeRadius * 2.5 * centerNodeProgress, glowPaint);
      
      nodePaint.color = mainNodeColor;
      canvas.drawCircle(center, centerNodeRadius * centerNodeProgress, nodePaint);
    }

    // --- Draw Paths and Outer Nodes with Dynamic Growth ---
    for (int i = 0; i < outerNodesPositions.length; i++) {
      final nodeProgress = _getAnimValue(0.15 + i * 0.1, 0.4, Curves.elasticOut);
      final pathProgress = _getAnimValue(0.25 + i * 0.1, 0.5, Curves.easeOut);
      
      if (nodeProgress > 0) {
        // Node "shoots" out from the center
        final currentPos = Offset.lerp(center, outerNodesPositions[i], nodeProgress)!;
        
        // Path "follows" the node
        if (pathProgress > 0) {
            final pathEndPos = Offset.lerp(center, outerNodesPositions[i], pathProgress)!;
            canvas.drawLine(center, pathEndPos, linePaint);
        }

        nodePaint.color = subNodeColor;
        canvas.drawCircle(currentPos, outerNodeRadius * nodeProgress, nodePaint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant _DynamicMindMapPainter oldDelegate) {
    return progress != oldDelegate.progress;
  }
}
