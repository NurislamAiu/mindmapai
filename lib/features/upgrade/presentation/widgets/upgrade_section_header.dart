import 'package:flutter/material.dart';

class UpgradeSectionHeader extends StatelessWidget {
  const UpgradeSectionHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 4.0),
      child: Text(
        'Choose a credit pack',
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade800,
            ),
      ),
    );
  }
}
