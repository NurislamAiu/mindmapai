import 'package:flutter/material.dart';

class CreditsIndicator extends StatelessWidget {
  final int creditCount;

  const CreditsIndicator({super.key, required this.creditCount});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return InkWell(
      onTap: () {
        // TODO: Implement action on tap, e.g., open "buy credits" screen
      },
      borderRadius: BorderRadius.circular(30.0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
        decoration: BoxDecoration(
          color: colorScheme.primary.withOpacity(0.05),
          borderRadius: BorderRadius.circular(30.0),
          border: Border.all(color: colorScheme.primary.withOpacity(0.1)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.auto_awesome_rounded,
              size: 16,
              color: colorScheme.primary,
            ),
            const SizedBox(width: 6),
            Text(
              '$creditCount AI Credits',
              style: textTheme.bodySmall?.copyWith(
                color: colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
