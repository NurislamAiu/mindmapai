import 'package:flutter/material.dart';
import '../../domain/entities/idea.dart';

class FocusCard extends StatelessWidget {
  final Idea? lastIdea;

  const FocusCard({super.key, this.lastIdea});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final bool hasIdea = lastIdea != null;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () { /* TODO: Handle tap */ },
          borderRadius: BorderRadius.circular(24.0),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: colorScheme.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: Icon(
                    hasIdea ? Icons.lightbulb_outline_rounded : Icons.auto_awesome_rounded,
                    color: colorScheme.primary,
                    size: 28,
                  ),
                ),
                const SizedBox(width: 16.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        hasIdea
                            ? 'Continue where you left off'
                            : 'Recommended next step',
                        style: textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: colorScheme.onSurface,
                        ),
                      ),
                      const SizedBox(height: 4.0),
                      Text(
                        hasIdea
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
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: Colors.grey[500],
                  size: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
