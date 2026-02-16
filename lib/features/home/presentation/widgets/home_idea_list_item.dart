import 'package:flutter/material.dart';
import '../../domain/entities/idea.dart';

class IdeaListItem extends StatelessWidget {
  final Idea idea;
  const IdeaListItem({super.key, required this.idea});

  @override
  Widget build(BuildContext context) {
    final bool isAnalyzed = idea.status == IdeaStatus.Analyzed;
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  idea.title,
                  style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(width: 16),
              Text(
                idea.date,
                style: textTheme.bodySmall?.copyWith(color: Colors.grey[500]),
              ),
            ],
          ),
          const SizedBox(height: 12.0),
          Text(
            idea.summary,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: textTheme.bodyMedium?.copyWith(color: Colors.grey[700]),
          ),
          const SizedBox(height: 16.0),
          _StatusChip(isAnalyzed: isAnalyzed),
        ],
      ),
    );
  }
}

class _StatusChip extends StatelessWidget {
  final bool isAnalyzed;

  const _StatusChip({required this.isAnalyzed});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final statusColor = isAnalyzed ? Colors.indigo.shade400 : Colors.grey.shade500;
    final backgroundColor = isAnalyzed ? Colors.indigo.shade50 : Colors.grey.shade100;
    final statusText = isAnalyzed ? 'Analyzed' : 'Draft';

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isAnalyzed ? Icons.check_circle_outline : Icons.edit_outlined,
            size: 14,
            color: statusColor,
          ),
          const SizedBox(width: 6.0),
          Text(
            statusText,
            style: textTheme.bodySmall?.copyWith(
              color: statusColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

