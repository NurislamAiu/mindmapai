import 'package:flutter/material.dart';
import '../../domain/entities/idea.dart';

class RecentIdeasSection extends StatelessWidget {
  final List<Idea> ideas;

  const RecentIdeasSection({super.key, required this.ideas});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          child: Text(
            'Recent ideas',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 12.0),
        ListView.separated(
          itemCount: ideas.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return _IdeaListItem(idea: ideas[index]);
          },
          separatorBuilder: (context, index) => const SizedBox(height: 10.0),
        ),
      ],
    );
  }
}

class _IdeaListItem extends StatelessWidget {
  final Idea idea;
  const _IdeaListItem({required this.idea});

  @override
  Widget build(BuildContext context) {
    final bool isAnalyzed = idea.status == IdeaStatus.Analyzed;
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(idea.title, style: textTheme.bodyLarge),
              ),
              Text(idea.date, style: textTheme.bodySmall?.copyWith(color: Colors.grey[400])),
            ],
          ),
          const SizedBox(height: 8.0),
          Text(
            idea.summary,
            style: textTheme.bodyMedium?.copyWith(color: Colors.grey[600]),
          ),
          const SizedBox(height: 12.0),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
            decoration: BoxDecoration(
              color: isAnalyzed ? Colors.indigo.shade50 : Colors.grey.shade100,
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 6,
                  height: 6,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isAnalyzed ? Colors.indigo.shade500 : Colors.grey.shade500,
                  ),
                ),
                const SizedBox(width: 6.0),
                Text(
                  isAnalyzed ? 'Analyzed' : 'Draft',
                  style: textTheme.bodySmall?.copyWith(
                    color: isAnalyzed ? Colors.indigo.shade600 : Colors.grey.shade600,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
