import 'package:flutter/material.dart';

// Enum для безопасной типизации цветов
enum TemplateColor { indigo, violet, blue, purple }

class Template {
  final int id;
  final String title;
  final String description;
  final IconData icon;
  final TemplateColor color;
  final String aiHint;
  final String outcome;
  final bool usesCredits;
  final String? reason; // Опционально, для рекомендованного шаблона

  Template({
    required this.id,
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
    required this.aiHint,
    required this.outcome,
    required this.usesCredits,
    this.reason,
  });
}
