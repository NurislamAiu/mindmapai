import 'package:flutter/material.dart';
import 'package:mindmapai/features/profile/domain/entities/user_entity.dart';

class ProfileStatsCard extends StatelessWidget {
  final UserEntity user;

  const ProfileStatsCard({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24.0), // Consistent radius
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05), // Consistent shadow
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 4.0, bottom: 16.0),
            child: Text(
              'Your Progress',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.grey[850],
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: _StatItem(
                  value: user.ideasAnalyzed.toString(),
                  label: 'Ideas analyzed',
                  icon: Icons.lightbulb_outline_rounded,
                  color: Colors.purple,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _StatItem(
                  value: user.daysActive.toString(),
                  label: 'Days active',
                  icon: Icons.calendar_today_outlined,
                  color: Colors.indigo,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String value;
  final String label;
  final IconData icon;
  final MaterialColor color;

  const _StatItem({
    required this.value,
    required this.label,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 12.0),
      decoration: BoxDecoration(
        // Simplified background
        color: color.shade50.withOpacity(0.7),
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // New icon style to match other cards
          Container(
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: Icon(icon, size: 24, color: color),
          ),
          const SizedBox(height: 16),
          Text(
            value,
            style: textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: color.shade900,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            textAlign: TextAlign.center,
            style: textTheme.bodyMedium?.copyWith(
              color: color.shade700,
            ),
          ),
        ],
      ),
    );
  }
}
