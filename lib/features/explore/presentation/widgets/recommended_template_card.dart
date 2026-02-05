import 'package:flutter/material.dart';
import '../../domain/entities/template.dart';
import 'template_card_widgets.dart'; // Общие элементы UI для карточек

class RecommendedTemplateCard extends StatelessWidget {
  final Template template;
  const RecommendedTemplateCard({super.key, required this.template});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final color = getTemplateColor(template.color).shade600;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.0),
          child: Row(
            children: [
              Icon(Icons.star_rounded, color: Colors.indigo, size: 20),
              SizedBox(width: 8),
              Text(
                'Recommended for you',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24.0),
            gradient: LinearGradient(
              colors: [getTemplateColor(template.color).shade50, Colors.indigo.shade50],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            border: Border.all(color: Colors.indigo.shade100.withOpacity(0.8)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TemplateHeader(template: template),
              const SizedBox(height: 12),
              TemplateBadges(template: template, isRecommended: true),
              const SizedBox(height: 12),
              Text(template.outcome, style: textTheme.bodySmall?.copyWith(color: Colors.grey[600])),
              const SizedBox(height: 8),
              if (template.reason != null)
                Text(
                  template.reason!,
                  style: textTheme.bodySmall?.copyWith(
                    color: color.withOpacity(0.8),
                    fontStyle: FontStyle.italic,
                  ),
                ),
            ],
          ),
        )
      ],
    );
  }
}
