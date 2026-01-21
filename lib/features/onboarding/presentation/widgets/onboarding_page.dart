import 'package:flutter/material.dart';
import 'dart:math' as math;

class OnboardingPage extends StatefulWidget {
  final String title;
  final String subtitle;
  final Widget visual;
  final int pageIndex;
  final double currentPage;

  const OnboardingPage({
    super.key,
    required this.title,
    required this.subtitle,
    required this.visual,
    required this.pageIndex,
    required this.currentPage,
  });

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<double> _opacityAnimation;
  late final Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOutQuart,
      ),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.2),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOutQuart,
      ),
    );

    // If the page is already visible on first build, start the animation
    if (widget.pageIndex == widget.currentPage.round()) {
      _animationController.forward();
    }
  }

  @override
  void didUpdateWidget(covariant OnboardingPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Animate in when the page becomes the current one
    if (widget.pageIndex == widget.currentPage.round() &&
        oldWidget.currentPage.round() != widget.pageIndex) {
      _animationController.forward(from: 0.0);
    }
    // Reset animation when page is no longer visible
    else if (widget.pageIndex != widget.currentPage.round() &&
        oldWidget.currentPage.round() == widget.pageIndex) {
      _animationController.reset();
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Calculate parallax effect based on scroll offset
    final double pageOffset = widget.currentPage - widget.pageIndex;

    // A value that is 1 when page is active, and 0 when it's one page away
    final double visibility = 1.0 - pageOffset.abs().clamp(0.0, 1.0);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Spacer(flex: 3),
          Transform.translate(
            offset: Offset(pageOffset * -80, 0), // Parallax for visual
            child: Opacity(
              opacity: visibility,
              child: widget.visual,
            ),
          ),
          const Spacer(flex: 3),
          SlideTransition(
            position: _slideAnimation,
            child: FadeTransition(
              opacity: _opacityAnimation,
              child: Text(
                widget.title,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
          ),
          const SizedBox(height: 16),
          SlideTransition(
            position: _slideAnimation,
            child: FadeTransition(
              opacity: _opacityAnimation,
              child: Text(
                widget.subtitle,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
          ),
          const Spacer(flex: 4),
        ],
      ),
    );
  }
}
