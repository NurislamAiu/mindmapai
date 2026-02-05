import 'package:flutter/material.dart';

class WhyUseTemplatesCard extends StatelessWidget {
  const WhyUseTemplatesCard({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Why use templates?',
            style: textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            'Templates help the AI understand your goal and structure the analysis to give you better, more actionable insights. Each template is designed to guide the AI toward the most useful output for that specific type of thinking.',
            style: textTheme.bodyMedium?.copyWith(color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }
}
