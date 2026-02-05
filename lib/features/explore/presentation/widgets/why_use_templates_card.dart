import 'package:flutter/material.dart';

class WhyUseTemplatesCard extends StatelessWidget {
  const WhyUseTemplatesCard({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        // 1. Акцентный фон с градиентом
        gradient: LinearGradient(
          colors: [
            Colors.indigo.shade50,
            Colors.purple.shade50,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.indigo.shade100.withOpacity(0.5)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 2. Иконка-акцент
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.8),
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Icon(
              Icons.help_outline_rounded,
              color: Colors.indigo.shade400,
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          // 3. Улучшенная компоновка текста
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Why use templates?',
                  style: textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade800,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Templates help the AI understand your goal and structure the analysis to give you better, more actionable insights. Each template is designed to guide the AI toward the most useful output for that specific type of thinking.',
                  style: textTheme.bodyMedium?.copyWith(
                    color: Colors.grey[700],
                    height: 1.5, // Увеличиваем межстрочный интервал для читаемости
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
