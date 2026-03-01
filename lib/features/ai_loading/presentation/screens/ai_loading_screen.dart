import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mindmapai/features/ai_loading/presentation/widgets/mind_map_animation.dart';
import 'package:mindmapai/features/ai_loading/presentation/widgets/thinking_steps_widget.dart';

class AiLoadingScreen extends StatefulWidget {
  final VoidCallback? onComplete;

  const AiLoadingScreen({super.key, this.onComplete});

  @override
  State<AiLoadingScreen> createState() => _AiLoadingScreenState();
}

class _AiLoadingScreenState extends State<AiLoadingScreen> {
  static const _thinkingSteps = [
    "Understanding your idea",
    "Identifying key concepts",
    "Building the mind map",
    "Generating clear next steps",
  ];

  int _currentStep = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
    
    // Simulate API call or some long running task
    // Here we wait for 8 seconds before moving to the result screen
    Future.delayed(const Duration(seconds: 8), () {
      if (mounted) {
        // Use context.go() to replace the current route, preventing
        // the user from navigating back to the loading screen
        context.go('/result');
      }
    });
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 2), (timer) {
      if (mounted) {
        setState(() {
          // Зацикливаем шаги
          _currentStep = (_currentStep + 1) % _thinkingSteps.length;
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 400),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const MindMapAnimation(),
              const SizedBox(height: 64),
              const Text(
                'Analyzing your idea',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF030213),
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 48),
              ThinkingStepsWidget(
                steps: _thinkingSteps,
                currentStep: _currentStep,
              ),
              const SizedBox(height: 48),
              const Text(
                'This usually takes less than a minute',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13,
                  color: Color(0xFF9A9AAA),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
