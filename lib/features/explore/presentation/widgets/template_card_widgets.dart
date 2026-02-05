import 'package:flutter/material.dart';
import '../../domain/entities/template.dart';

// Helper to convert TemplateColor enum to MaterialColor
MaterialColor getTemplateColor(TemplateColor color) {
  switch (color) {
    case TemplateColor.indigo: return Colors.indigo;
    case TemplateColor.violet: return Colors.purple; // Using purple for violet
    case TemplateColor.blue: return Colors.blue;
    case TemplateColor.purple: return Colors.purple;
  }
}

// Widget for the header (Icon + Title + Description)
class TemplateHeader extends StatelessWidget {
  final Template template;
  final bool useLargeIcon;
  const TemplateHeader({super.key, required this.template, this.useLargeIcon = true});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final color = getTemplateColor(template.color);
    
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: useLargeIcon ? 48 : 40,
          height: useLargeIcon ? 48 : 40,
          decoration: BoxDecoration(
            color: color.shade100,
            borderRadius: BorderRadius.circular(useLargeIcon ? 16 : 12),
          ),
          child: Icon(template.icon, color: color.shade600),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(template.title, style: textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              Text(
                template.description,
                style: textTheme.bodyMedium?.copyWith(color: Colors.grey[600]),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// Widget for the badges (AI Hint, Credits)
class TemplateBadges extends StatelessWidget {
  final Template template;
  final bool isRecommended;
  const TemplateBadges({super.key, required this.template, this.isRecommended = false});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8.0,
      runSpacing: 8.0,
      children: [
        _Badge(
          label: template.aiHint,
          icon: Icons.auto_awesome_rounded,
          backgroundColor: isRecommended ? Colors.white.withOpacity(0.8) : Colors.grey.shade100,
          foregroundColor: isRecommended ? getTemplateColor(template.color).shade700 : Colors.grey.shade700,
        ),
        if (template.usesCredits)
          _Badge(
            label: 'Uses AI credits',
            backgroundColor: isRecommended ? Colors.white.withOpacity(0.8) : Colors.grey.shade100,
            foregroundColor: Colors.grey.shade600,
          ),
      ],
    );
  }
}

class _Badge extends StatelessWidget {
  final String label;
  final IconData? icon;
  final Color backgroundColor;
  final Color foregroundColor;

  const _Badge({
    required this.label,
    this.icon,
    required this.backgroundColor,
    required this.foregroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 12, color: foregroundColor),
            const SizedBox(width: 4),
          ],
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: foregroundColor,
              fontWeight: icon != null ? FontWeight.w500 : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
