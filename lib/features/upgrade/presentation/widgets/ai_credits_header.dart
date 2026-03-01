import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class AICreditsHeader extends StatelessWidget {
  const AICreditsHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'AI Credits',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w400,
            color: Colors.grey[900],
          ),
        ),
        const Gap(8),
        Text(
          'Manage and understand how your AI credits are used.',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w300,
            color: Colors.grey[600],
            height: 1.5,
          ),
        ),
      ],
    );
  }
}
