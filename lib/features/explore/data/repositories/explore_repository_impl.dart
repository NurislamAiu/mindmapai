import 'package:flutter/material.dart';
import '../../domain/entities/explore_template.dart';
import '../../domain/repositories/explore_repository.dart';

class ExploreRepositoryImpl implements ExploreRepository {
  @override
  Future<Template> getRecommendedTemplate() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return Template(
      id: 99,
      title: "Product Roadmap",
      description: "Plan features, priorities, and development phases for your product",
      icon: Icons.rocket_launch_outlined,
      color: TemplateColor.indigo,
      aiHint: "AI-guided roadmap",
      outcome: "Get: Feature map, timeline, priorities",
      reason: "Based on your recent project planning",
      usesCredits: true,
    );
  }

  @override
  Future<List<Template>> getPopularTemplates() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return [
      Template(
        id: 1,
        title: "Business Strategy",
        description: "Structure your business ideas with guided AI prompts",
        icon: Icons.business_center_outlined,
        color: TemplateColor.indigo,
        aiHint: "Guided AI analysis",
        outcome: "Get: Strategy map, key insights, action steps",
        usesCredits: true,
      ),
      Template(
        id: 2,
        title: "Learning Goals",
        description: "Break down complex topics into learning paths",
        icon: Icons.school_outlined,
        color: TemplateColor.violet,
        aiHint: "Structured breakdown",
        outcome: "Get: Learning roadmap, milestones, resources",
        usesCredits: true,
      ),
      Template(
        id: 3,
        title: "Project Planning",
        description: "Map out project phases, tasks, and dependencies",
        icon: Icons.flag_outlined,
        color: TemplateColor.blue,
        aiHint: "Smart task analysis",
        outcome: "Get: Project timeline, dependencies, priorities",
        usesCredits: true,
      ),
      Template(
        id: 4,
        title: "Growth Ideas",
        description: "Explore opportunities and expansion strategies",
        icon: Icons.trending_up,
        color: TemplateColor.purple,
        aiHint: "Opportunity mapping",
        outcome: "Get: Growth map, opportunities, next steps",
        usesCredits: true,
      ),
    ];
  }
}
