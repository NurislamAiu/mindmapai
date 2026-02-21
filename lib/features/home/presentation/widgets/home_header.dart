import 'package:flutter/material.dart';
import 'package:mindmapai/features/home/presentation/widgets/home_credits_indicator.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({
    super.key,
    required this.creditsRemaining,
  });

  final int creditsRemaining;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          'Welcome back',
          style: TextStyle(fontSize: 24, color: Color(0xFF111827)),
        ),
        HomeCreditsIndicator(creditCount: creditsRemaining),
      ],
    );
  }
}
