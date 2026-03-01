import 'dart:math';
import 'package:flutter/material.dart';

class BranchWidget extends StatefulWidget {
  final Duration delay;
  final double angle;
  final double length;

  const BranchWidget({
    super.key,
    required this.delay,
    required this.angle,
    required this.length,
  });

  @override
  State<BranchWidget> createState() => _BranchWidgetState();
}

class _BranchWidgetState extends State<BranchWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _lineWidthAnimation;
  late final Animation<double> _nodeScaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200), // Slightly longer for a smoother feel
    );

    _lineWidthAnimation = Tween<double>(begin: 0.0, end: widget.length).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.7, curve: Curves.easeOut),
      ),
    );

    _nodeScaleAnimation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 0.0, end: 1.2), weight: 60),
      TweenSequenceItem(tween: Tween(begin: 1.2, end: 1.0), weight: 40),
    ]).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.5, 1.0, curve: Curves.easeOutBack), // Bouncier curve
      ),
    );

    Future.delayed(widget.delay, () {
      if (mounted) {
        _controller.forward();
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
    const startColor = Color(0xFF89F7FE);
    const endColor = Color(0xFF66A6FF);

    return Transform.rotate(
      angle: widget.angle * (pi / 180),
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          // Branch line
          AnimatedBuilder(
            animation: _lineWidthAnimation,
            builder: (context, child) {
              return Container(
                width: _lineWidthAnimation.value,
                height: 3, // Slightly thicker
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2),
                  gradient: const LinearGradient(
                    colors: [startColor, endColor],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: endColor.withOpacity(0.4),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
              );
            },
          ),
          // End node
          Padding(
            padding: EdgeInsets.only(left: widget.length),
            child: ScaleTransition(
              scale: _nodeScaleAnimation,
              child: Container(
                width: 14,
                height: 14,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: const RadialGradient(
                    colors: [Colors.white, endColor],
                    stops: [0.1, 1.0],
                  ),
                  border: Border.all(color: Colors.white.withOpacity(0.8), width: 1.5),
                  boxShadow: [
                    BoxShadow(
                      color: endColor.withOpacity(0.6),
                      blurRadius: 10,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
