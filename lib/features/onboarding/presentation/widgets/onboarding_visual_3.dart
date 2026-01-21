import 'dart:ui';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class OnboardingVisual3 extends StatefulWidget {
  final bool isVisible;
  const OnboardingVisual3({super.key, required this.isVisible});

  @override
  State<OnboardingVisual3> createState() => _OnboardingVisual3State();
}

class _OnboardingVisual3State extends State<OnboardingVisual3>
    with TickerProviderStateMixin {
  late final AnimationController _controller;
  late final AnimationController _rotationController;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2800),
    );
    _rotationController = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 20000),
    )..repeat();

    if (widget.isVisible) {
      _controller.forward();
    }
  }

  @override
  void didUpdateWidget(covariant OnboardingVisual3 oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isVisible && !oldWidget.isVisible) {
      _controller.forward(from: 0.0);
      _rotationController.repeat();
    } else if (!widget.isVisible && oldWidget.isVisible) {
      _controller.reset();
      _rotationController.stop();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _rotationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([_controller, _rotationController]),
      builder: (context, child) {
        return Transform.rotate(
          angle: _rotationController.value * 2 * math.pi,
          child: CustomPaint(
            painter: _EvolvingMindMapPainter(_controller.value),
            size: const Size(300, 300),
          ),
        );
      },
    );
  }
}

class _EvolvingMindMapPainter extends CustomPainter {
  final double progress;
  _EvolvingMindMapPainter(this.progress);
  
  double _getAnimValue(double start, double duration, [Curve curve = Curves.easeInOut]) {
    return curve.transform(((progress - start) / duration).clamp(0.0, 1.0));
  }
  
  void _drawAnimatedPath(Canvas canvas, Offset from, Offset to, double p, Paint paint) {
      if (p <= 0) return;
      final currentEnd = Offset.lerp(from, to, p)!;
      canvas.drawLine(from, currentEnd, paint);
  }

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final mainNodeColor = Colors.indigo[600]!;
    final secondaryNodeColor = Colors.indigo[400]!;
    final tertiaryNodeColor = Colors.indigo[300]!;
    final lineColor = Colors.indigo[400]!.withOpacity(0.5);

    final linePaint = (double stroke) => Paint()
      ..color = lineColor
      ..strokeWidth = stroke
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;
    
    final nodePaint = Paint()..style = PaintingStyle.fill;
    
    // --- Node Positions ---
    final centerNode = (radius: 16.0, color: mainNodeColor);
    final secondaryNodes = List.generate(4, (i) {
      final angle = (i * 90.0) * (math.pi / 180);
      return (
        pos: Offset(center.dx + 85 * math.cos(angle), center.dy + 85 * math.sin(angle)),
        radius: 10.0, color: secondaryNodeColor,
      );
    });
    final tertiaryNodes = List.generate(8, (i) {
        final parentIndex = i ~/ 2;
        final parentPos = secondaryNodes[parentIndex].pos;
        final angle = (parentIndex * 90.0 + (i % 2 == 0 ? -30 : 30)) * (math.pi / 180);
        return (
          pos: Offset(center.dx + 140 * math.cos(angle), center.dy + 140 * math.sin(angle)),
          radius: 7.0, color: tertiaryNodeColor
        );
    });

    // --- Draw Center Node ---
    final centerNodeProgress = _getAnimValue(0.0, 0.15, Curves.elasticOut);
    if (centerNodeProgress > 0) {
       final glowPaint = Paint()
        ..color = mainNodeColor.withOpacity(0.3 * centerNodeProgress)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 25.0);
      canvas.drawCircle(center, centerNode.radius * 2.5 * centerNodeProgress, glowPaint);
      
      nodePaint.color = centerNode.color;
      canvas.drawCircle(center, centerNode.radius * centerNodeProgress, nodePaint);
    }
    
    // --- Primary Paths and Secondary Nodes ---
    for(int i = 0; i < 4; i++) {
        final pathProgress = _getAnimValue(0.1 + i * 0.08, 0.3);
        final nodeProgress = _getAnimValue(0.15 + i * 0.08, 0.3, Curves.elasticOut);
        
        _drawAnimatedPath(canvas, center, secondaryNodes[i].pos, pathProgress, linePaint(2.0));

        if(nodeProgress > 0) {
            nodePaint.color = secondaryNodes[i].color;
            canvas.drawCircle(secondaryNodes[i].pos, secondaryNodes[i].radius * nodeProgress, nodePaint);
        }
    }

    // --- Secondary Paths and Tertiary Nodes ---
    for(int i = 0; i < 8; i++) {
        final parentIndex = i ~/ 2;
        final pathProgress = _getAnimValue(0.45 + i * 0.05, 0.3);
        final nodeProgress = _getAnimValue(0.5 + i * 0.05, 0.3, Curves.elasticOut);

        _drawAnimatedPath(canvas, secondaryNodes[parentIndex].pos, tertiaryNodes[i].pos, pathProgress, linePaint(1.5));

        if(nodeProgress > 0) {
            nodePaint.color = tertiaryNodes[i].color;
            canvas.drawCircle(tertiaryNodes[i].pos, tertiaryNodes[i].radius * nodeProgress, nodePaint);
        }
    }
  }

  @override
  bool shouldRepaint(covariant _EvolvingMindMapPainter oldDelegate) {
    return progress != oldDelegate.progress;
  }
}
