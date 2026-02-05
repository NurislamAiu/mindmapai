import 'package:flutter/material.dart';
import '../../domain/entities/idea.dart';

class IdeaListItem extends StatelessWidget {
  final Idea idea;
  const IdeaListItem({super.key, required this.idea});

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
