import 'package:flutter/material.dart';
import 'package:mindmapai/features/home/domain/entities/idea.dart';
import 'package:mindmapai/features/home/presentation/widgets/home_focus_card.dart';
import 'package:mindmapai/features/home/presentation/widgets/home_primary_action_card.dart';
import 'package:mindmapai/features/home/presentation/widgets/home_quick_actions_row.dart';
import 'package:mindmapai/features/home/presentation/widgets/home_recent_ideas_section.dart';
import 'package:mindmapai/features/home/presentation/widgets/home_status_card.dart';

class ExistingUserContent extends StatelessWidget {
  const ExistingUserContent({
    super.key,
    required this.focusData,
    required this.recentIdeas,
  });

  final FocusCardData focusData;
  final List<Idea> recentIdeas;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
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
        IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Expanded(
                child: HomeStatusCard(
                  status: StatusInfo(
                    title: 'Startup Readiness',
                    percentage: 62,
                    risk: RiskLevel.Medium,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: HomeFocusCard(data: focusData),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        const HomeQuickActionsRow(),
        const SizedBox(height: 24),
        HomeRecentIdeasSection(ideas: recentIdeas),
      ],
    );
  }
}
