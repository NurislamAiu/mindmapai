import 'package:flutter/material.dart';

class UpgradeHeader extends StatelessWidget {
  const UpgradeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      children: [
        Image.asset(
          'assets/icon/icon.png',
          height: 120,
          width: 120,
        ),
        const SizedBox(height: 24),
        Text(
          'Go deeper with MINDRA',
          textAlign: TextAlign.center,
          style: textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade900,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          "You've used your free AI analyses. Choose how you'd like to continue exploring your ideas.",
          textAlign: TextAlign.center,
          style: textTheme.bodyLarge?.copyWith(
            color: Colors.grey.shade600,
            height: 1.5,
          ),
        ),
      ],
    );
  }
}
