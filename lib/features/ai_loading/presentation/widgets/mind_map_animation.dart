import 'dart:ui';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class MindMapAnimation extends StatefulWidget {
  const MindMapAnimation({super.key});

  @override
  State<MindMapAnimation> createState() => _MindMapAnimationState();
}

class _MindMapAnimationState extends State<MindMapAnimation>
    with TickerProviderStateMixin {
  late final AnimationController _evolveController;
  late final AnimationController _rotationController;

  @override
  void initState() {
    super.initState();
    _evolveController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3500),
    )..repeat(reverse: true);

    _rotationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 25000),
    )..repeat();
  }

  @override
  void dispose() {
    _evolveController.dispose();
    _rotationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 256,
      height: 256,
      child: AnimatedBuilder(
        animation: Listenable.merge([_evolveController, _rotationController]),
        builder: (context, child) {
          return Transform.rotate(
            angle: _rotationController.value * 2 * math.pi,
            child: CustomPaint(
              painter: _MindMapPainter(_evolveController.value),
              size: const Size(256, 256),
            ),
          );
        },
      ),
    );
  }
}

class _MindMapPainter extends CustomPainter {
  final double progress;
  _MindMapPainter(this.progress);

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

    // New color palette
    const mainNodeColor = Color(0xFF9D4EDD); // A vibrant purple
    const secondaryNodeColor = Color(0xFFC77DFF); // A lighter purple
    const tertiaryColor = Color(0xFFFFC8DD); // A soft pink

    final linePaint = (double stroke) => Paint()
      ..strokeWidth = stroke
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..shader = const LinearGradient(
        colors: [secondaryNodeColor, tertiaryColor],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(Rect.fromCircle(center: center, radius: size.width / 2));

    final nodePaint = Paint()..style = PaintingStyle.fill;

    // --- Node Positions ---
    final centerNode = (radius: 18.0, color: mainNodeColor);
    final secondaryNodes = List.generate(6, (i) {
      final angle = (i * 60.0) * (math.pi / 180);
      return (
        pos: Offset(center.dx + 70 * math.cos(angle), center.dy + 70 * math.sin(angle)),
        radius: 9.0,
        color: secondaryNodeColor,
      );
    });
    final tertiaryNodes = List.generate(6, (i) {
      final parentPos = secondaryNodes[i].pos;
      final angle = (i * 60.0 + 30) * (math.pi / 180); // Offset from parent
      return (
        pos: Offset(center.dx + 115 * math.cos(angle), center.dy + 115 * math.sin(angle)),
        radius: 6.0,
        color: const Color(0xFFFFF0F3), // Very light pink
      );
    });

    // --- Draw Center Node ---
    final centerNodeProgress = _getAnimValue(0.0, 0.15, Curves.elasticOut);
    if (centerNodeProgress > 0) {
      final glowPaint = Paint()
        ..color = mainNodeColor.withOpacity((0.4 * centerNodeProgress).clamp(0.0, 1.0))
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 30.0);
      canvas.drawCircle(center, centerNode.radius * 2.8 * centerNodeProgress, glowPaint);

      nodePaint.color = centerNode.color;
      canvas.drawCircle(center, centerNode.radius * centerNodeProgress, nodePaint);
    }

    // --- Primary Paths and Secondary Nodes ---
    for (int i = 0; i < secondaryNodes.length; i++) {
      final pathProgress = _getAnimValue(0.1 + i * 0.07, 0.3);
      final nodeProgress = _getAnimValue(0.15 + i * 0.07, 0.3, Curves.elasticOut);

      _drawAnimatedPath(canvas, center, secondaryNodes[i].pos, pathProgress, linePaint(2.5));

      if (nodeProgress > 0) {
        nodePaint.color = secondaryNodes[i].color;
        canvas.drawCircle(secondaryNodes[i].pos, secondaryNodes[i].radius * nodeProgress, nodePaint);
      }
    }

    // --- Secondary Paths and Tertiary Nodes ---
    for (int i = 0; i < tertiaryNodes.length; i++) {
      final pathProgress = _getAnimValue(0.45 + i * 0.06, 0.3);
      final nodeProgress = _getAnimValue(0.5 + i * 0.06, 0.3, Curves.elasticOut);

      _drawAnimatedPath(canvas, secondaryNodes[i].pos, tertiaryNodes[i].pos, pathProgress, linePaint(1.5));
      
      if (nodeProgress > 0) {
        final tertiaryPaint = Paint()..color = tertiaryNodes[i].color.withOpacity(nodeProgress.clamp(0.0, 1.0));
        final tertiaryBorderPaint = Paint()
          ..color = secondaryNodeColor.withOpacity(nodeProgress.clamp(0.0, 1.0))
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2.0;
          
        canvas.drawCircle(tertiaryNodes[i].pos, tertiaryNodes[i].radius * nodeProgress, tertiaryPaint);
        canvas.drawCircle(tertiaryNodes[i].pos, tertiaryNodes[i].radius * nodeProgress, tertiaryBorderPaint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant _MindMapPainter oldDelegate) {
    return progress != oldDelegate.progress;
  }
}
