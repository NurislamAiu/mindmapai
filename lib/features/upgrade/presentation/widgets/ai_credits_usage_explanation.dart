import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class AICreditsUsageExplanation extends StatelessWidget {
  const AICreditsUsageExplanation({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey[100]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'How credits work',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.grey[700],
            ),
          ),
          const Gap(12),
          Text(
            'AI credits are used when generating or refining structured insights and mind maps. Each analysis or refinement consumes one credit, giving you comprehensive AI-powered results.',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w300,
              color: Colors.grey[600],
              height: 1.5,
            ),
          ),
          const Gap(16),
          const Divider(color: Color(0xFFF3F4F6), height: 1), // gray-100
          const Gap(16),
          Text(
            'Pro subscribers receive monthly credits that renew automatically. One-time credit packs never expire.',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w300,
              color: Colors.grey[600],
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
