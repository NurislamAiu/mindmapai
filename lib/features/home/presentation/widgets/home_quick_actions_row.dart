import 'package:flutter/material.dart';

class QuickActionsRow extends StatelessWidget {
  const QuickActionsRow({super.key});
  
  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Expanded(child: _QuickActionButton(icon: Icons.lightbulb_outline, label: 'New idea')),
        SizedBox(width: 12.0),
        Expanded(child: _QuickActionButton(icon: Icons.file_copy_outlined, label: 'Templates')),
        SizedBox(width: 12.0),
        Expanded(child: _QuickActionButton(icon: Icons.bookmark_border_rounded, label: 'Saved')),
      ],
    );
  }
}

class _QuickActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  const _QuickActionButton({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.0),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: Icon(icon, color: Colors.grey.shade800),
          ),
          const SizedBox(height: 8.0),
          Text(label, style: Theme.of(context).textTheme.bodySmall),
        ],
      ),
    );
  }
}
