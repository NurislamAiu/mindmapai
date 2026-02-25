import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../domain/entities/explore_template.dart';
import 'explore_template_card_widgets.dart';

class TemplateListItem extends StatelessWidget {
  final Template template;
  const TemplateListItem({super.key, required this.template});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24.0),
        border: Border.all(color: Colors.grey.shade200),
        // 1. Добавляем легкую тень для глубины
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade100.withOpacity(0.7),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => context.push('/guided-input', extra: template),
          borderRadius: BorderRadius.circular(24.0),
          hoverColor: getTemplateColor(template.color).shade50.withOpacity(0.5),
          highlightColor: getTemplateColor(template.color).shade50,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header section остается таким же чистым
                TemplateHeader(template: template, useLargeIcon: false),
                
                // 2. Добавляем изящный разделитель
                Divider(
                  height: 32,
                  thickness: 1,
                  color: Colors.grey.shade100,
                ),
                
                // Badges
                TemplateBadges(template: template),
                const SizedBox(height: 16),
                
                // Footer section
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Text(
                        template.outcome,
                        style: textTheme.bodySmall?.copyWith(color: Colors.grey[600]),
                      ),
                    ),
                    const SizedBox(width: 8),
                    // 3. Улучшаем контраст иконки
                    Icon(
                      Icons.arrow_forward_rounded,
                      size: 20,
                      color: Colors.grey.shade400, // Чуть темнее
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
