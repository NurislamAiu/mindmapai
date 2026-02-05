import 'package:flutter/material.dart';
import '../../domain/entities/idea.dart';

class FocusCard extends StatelessWidget {
  final Idea? lastIdea;

  const FocusCard({super.key, this.lastIdea});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24.0),
        gradient: LinearGradient(
          colors: [Colors.purple.shade50, Colors.indigo.shade50],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(color: Colors.purple.shade100.withOpacity(0.5)),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.8),
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Icon(
              lastIdea != null ? Icons.lightbulb_outline_rounded : Icons.auto_awesome_rounded,
              color: Colors.purple[600],
            ),
          ),
          const SizedBox(width: 12.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  lastIdea != null
                      ? 'Continue where you left off'
                      : 'Recommended next step',
                  style: textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4.0),
                Text(
                  lastIdea != null
                      ? '${lastIdea!.title} • Started ${lastIdea!.date}'
                      : 'Try analyzing your first idea to see how AI can help.',
                  style: textTheme.bodyMedium?.copyWith(color: Colors.grey[600]),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          const SizedBox(width: 8.0),
          Icon(Icons.arrow_forward_ios_rounded, color: Colors.grey[400], size: 16),
        ],
      ),
    );
  }
}
