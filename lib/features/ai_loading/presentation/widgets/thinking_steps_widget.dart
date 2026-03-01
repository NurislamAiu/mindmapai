import 'package:flutter/material.dart';

class ThinkingStepsWidget extends StatelessWidget {
  final int currentStep;
  final List<String> steps;

  const ThinkingStepsWidget({
    super.key,
    required this.currentStep,
    required this.steps,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(steps.length, (index) {
        return _StepItem(
          text: steps[index],
          isActive: index == currentStep,
          isCompleted: index < currentStep,
        );
      }),
    );
  }
}

class _StepItem extends StatefulWidget {
  final String text;
  final bool isActive;
  final bool isCompleted;

  const _StepItem({
    required this.text,
    required this.isActive,
    required this.isCompleted,
  });

  @override
  State<_StepItem> createState() => _StepItemState();
}

class _StepItemState extends State<_StepItem> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    if (widget.isActive) {
      _controller.repeat();
    }
  }

  @override
  void didUpdateWidget(covariant _StepItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isActive != oldWidget.isActive) {
      if (widget.isActive) {
        _controller.repeat();
      } else {
        _controller.stop();
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Color textColor;
    final FontWeight fontWeight;
    if (widget.isActive) {
      textColor = const Color(0xFF030213);
      fontWeight = FontWeight.w500;
    } else if (widget.isCompleted) {
      textColor = const Color(0xFF717182);
      fontWeight = FontWeight.normal;
    } else {
      textColor = const Color(0xFF9A9AAA);
      fontWeight = FontWeight.normal;
    }

    return AnimatedOpacity(
      duration: const Duration(milliseconds: 300),
      opacity: widget.isCompleted || widget.isActive ? 1.0 : 0.35,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
        child: Row(
          children: [
            SizedBox(
              width: 24,
              height: 24,
              child: Center(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    if (widget.isActive)
                      ScaleTransition(
                        scale: Tween(begin: 1.0, end: 2.0).animate(
                          CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
                        ),
                        child: FadeTransition(
                          opacity: Tween(begin: 0.5, end: 0.0).animate(_controller),
                          child: const CircleAvatar(
                            radius: 3,
                            backgroundColor: Color(0xFF9376F2),
                          ),
                        ),
                      ),
                    CircleAvatar(
                      radius: 3,
                      backgroundColor: widget.isActive
                          ? const Color(0xFF6D42E8)
                          : widget.isCompleted
                              ? const Color(0xFFC4B5FD)
                              : const Color(0xFFD4D4D8),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 4),
            Text(
              widget.text,
              style: TextStyle(
                fontSize: 15,
                color: textColor,
                fontWeight: fontWeight,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
