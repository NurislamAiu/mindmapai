import 'package:flutter/material.dart';
import 'package:mindmapai/features/home/domain/entities/idea.dart';
import 'package:mindmapai/features/home/presentation/widgets/home_credits_indicator.dart';
import 'package:mindmapai/features/home/presentation/widgets/home_empty_state.dart';
import 'package:mindmapai/features/home/presentation/widgets/home_focus_card.dart';
import 'package:mindmapai/features/home/presentation/widgets/home_primary_action_card.dart';
import 'package:mindmapai/features/home/presentation/widgets/home_quick_actions_row.dart';
import 'package:mindmapai/features/home/presentation/widgets/home_recent_ideas_section.dart';
import 'package:mindmapai/features/home/presentation/widgets/home_status_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // This data would typically come from a state management solution
    final recentIdeas = [
      Idea(
        id: 1,
        title: 'Mobile app redesign',
        summary: 'Exploring user-centered design principles for better engagement',
        date: '2 hours ago',
        status: IdeaStatus.Analyzed,
      ),
      Idea(
        id: 2,
        title: 'Q1 marketing strategy',
        summary: 'Breaking down channels, budget allocation, and timeline',
        date: 'Yesterday',
        status: IdeaStatus.Analyzed,
      ),
      Idea(
        id: 3,
        title: 'Product roadmap planning',
        summary: 'Feature prioritization and development phases',
        date: '3 days ago',
        status: IdeaStatus.Draft,
      ),
    ];
    const creditsRemaining = 2;
    const hasIdeas = true;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFF8FAFC),
              Color(0x33F5F3FF),
              Colors.white,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 500),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 16),
                    const Text(
                      'Welcome back',
                      style: TextStyle(fontSize: 24, color: Color(0xFF111827)),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'What would you like to think through today?',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[600],
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      '3 ideas analyzed this week',
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFF4F46E5),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 24),
                    const HomePrimaryActionCard(),
                    const SizedBox(height: 16),
                    const HomeStatusCard(),
                    const SizedBox(height: 16),
                    HomeFocusCard(hasIdeas: hasIdeas),
                    const SizedBox(height: 16),
                    const HomeQuickActionsRow(),
                    const SizedBox(height: 24),
                    if (hasIdeas)
                      HomeRecentIdeasSection(ideas: recentIdeas)
                    else
                      const HomeEmptyState(),
                    const SizedBox(height: 24),
                    const Center(
                      child: HomeCreditsIndicator(creditCount: creditsRemaining),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
