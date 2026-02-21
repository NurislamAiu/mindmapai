import 'package:flutter/material.dart';

class ShowcaseIdea {
  final String title;
  final String metricLabel;
  final String metricValue;
  final String insight;
  final Color color;

  const ShowcaseIdea({
    required this.title,
    required this.metricLabel,
    required this.metricValue,
    required this.insight,
    required this.color,
  });
}
