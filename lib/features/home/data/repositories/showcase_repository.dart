import 'package:flutter/material.dart';
import 'package:mindmapai/features/home/domain/entities/showcase_idea.dart';

class ShowcaseRepository {
  // In a real app, this would fetch data from an API or database.
  List<ShowcaseIdea> getShowcaseIdeas() {
    return [
      const ShowcaseIdea(
        title: 'Eco-Friendly Subscription Box',
        metricLabel: 'Readiness to Launch',
        metricValue: '85%',
        insight: "High potential in the 'conscious consumption' niche.",
        color: Color(0xFF059669), // Green
      ),
      const ShowcaseIdea(
        title: 'AI-Powered Finance App',
        metricLabel: 'Risk Level',
        metricValue: 'Low',
        insight: 'Main competitor has a poor user experience.',
        color: Color(0xFF4F46E5), // Indigo
      ),
      const ShowcaseIdea(
        title: 'Drone Rental for Real Estate',
        metricLabel: 'Market Fit Score',
        metricValue: '92/100',
        insight: 'Growing demand for high-quality property visuals.',
        color: Color(0xFFD97706), // Amber
      ),
    ];
  }
}
