import 'package:flutter/material.dart';

class AppInfo extends StatelessWidget {
  const AppInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24.0),
      child: Center(
        child: Column(
          children: [
            Text('MindMapAI v1.0.0',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: Colors.grey.shade500, fontWeight: FontWeight.w300)),
            const SizedBox(height: 4),
            Text('© 2024 MindMapAI. All rights reserved.',
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(color: Colors.grey.shade400, fontWeight: FontWeight.w300)),
          ],
        ),
      ),
    );
  }
}
