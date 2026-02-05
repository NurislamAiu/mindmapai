import 'package:flutter/material.dart';
import '../../domain/entities/template.dart';
import 'template_card_widgets.dart';

class TemplateListItem extends StatelessWidget {
  final Template template;
  const TemplateListItem({super.key, required this.template});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24.0),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TemplateHeader(template: template, useLargeIcon: false),
          const SizedBox(height: 12),
          TemplateBadges(template: template),
          const SizedBox(height: 12),
          Text(template.outcome, style: textTheme.bodySmall?.copyWith(color: Colors.grey[600])),
        ],
      ),
    );
  }
}
