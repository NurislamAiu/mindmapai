import 'package:flutter/material.dart';

class UpgradeHeaderSymbol extends StatefulWidget {
  const UpgradeHeaderSymbol({super.key});

  @override
  State<UpgradeHeaderSymbol> createState() => _UpgradeHeaderSymbolState();
}

class _UpgradeHeaderSymbolState extends State<UpgradeHeaderSymbol>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700), // Быстрая и плавная анимация
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic, // Приятная кривая замедления
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 1. Используем стандартные виджеты для анимации - это надежно и быстро
    return FadeTransition(
      opacity: _animation,
      child: ScaleTransition(
        scale: _animation,
        child: SizedBox(
          width: 100,
          height: 100,
          child: CustomPaint(
            // 2. Painter теперь статичный и не зависит от анимации
            painter: _MindMapPainter(),
          ),
        ),
      ),
    );
  }
}

// 3. Painter теперь максимально простой: он просто рисует полную иконку
class _MindMapPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);

    // --- Paints ---
    final mainPaint = Paint()
      ..strokeWidth = 1.5
      ..strokeCap = StrokeCap.round
      ..color = const Color(0x806366F1);
    final secondaryPaint = Paint()
      ..strokeWidth = 1.0
      ..strokeCap = StrokeCap.round
      ..color = const Color(0x66818CF8);
    final primaryNodePaint = Paint()..color = const Color(0xB3818CF8);
    final secondaryNodePaint = Paint()..color = const Color(0x99A5B4FC);
    final centerNodePaint = Paint()..color = const Color(0xFF6366F1);

    // --- Glow ---
    final glowPaint = Paint()
      ..shader = const RadialGradient(
        colors: [Color(0x1F6366F1), Color(0x006366F1)],
      ).createShader(Rect.fromCircle(center: center, radius: size.width / 2));
    canvas.drawCircle(center, size.width / 2.5, glowPaint);

    // --- Primary Connections & Nodes ---
    final primaryOffsets = {
      'top': center + const Offset(0, -25),
      'left': center + const Offset(-25, 0),
      'right': center + const Offset(25, 0),
      'bottom': center + const Offset(0, 25),
    };
    primaryOffsets.forEach((_, offset) {
      canvas.drawLine(center, offset, mainPaint);
      canvas.drawCircle(offset, 3.5, primaryNodePaint);
    });

    // --- Secondary Connections & Nodes ---
    // Восстанавливаем все недостающие линии и узлы
    final secondaryOffsets = {
      primaryOffsets['top']!: [center + const Offset(-12, -40), center + const Offset(12, -40)],
      primaryOffsets['left']!: [center + const Offset(-40, -12), center + const Offset(-40, 12)],
      primaryOffsets['right']!: [center + const Offset(40, -12), center + const Offset(40, 12)],
      primaryOffsets['bottom']!: [center + const Offset(-12, 40), center + const Offset(12, 40)],
    };
    secondaryOffsets.forEach((start, ends) {
      for (var end in ends) {
        canvas.drawLine(start, end, secondaryPaint);
        canvas.drawCircle(end, 2.5, secondaryNodePaint);
      }
    });

    // --- Central Node ---
    canvas.drawCircle(center, 5, centerNodePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
