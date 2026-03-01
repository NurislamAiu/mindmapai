import 'package:flutter/material.dart';
import '../providers/ideas_provider.dart';

class IdeasFilterTabs extends StatelessWidget {
  final IdeaFilter activeFilter;
  final ValueChanged<IdeaFilter> onFilterChanged;

  const IdeasFilterTabs({super.key, required this.activeFilter, required this.onFilterChanged});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _FilterButton(
          label: 'All',
          isActive: activeFilter == IdeaFilter.All,
          onTap: () => onFilterChanged(IdeaFilter.All),
        ),
        const SizedBox(width: 8),
        _FilterButton(
          label: 'Analyzed',
          isActive: activeFilter == IdeaFilter.Analyzed,
          onTap: () => onFilterChanged(IdeaFilter.Analyzed),
        ),
        const SizedBox(width: 8),
        _FilterButton(
          label: 'Drafts',
          isActive: activeFilter == IdeaFilter.Drafts,
          onTap: () => onFilterChanged(IdeaFilter.Drafts),
        ),
      ],
    );
  }
}

class _FilterButton extends StatelessWidget {
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _FilterButton({required this.label, required this.isActive, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: isActive ? Colors.grey[900] : Colors.white,
        foregroundColor: isActive ? Colors.white : Colors.grey[600],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        elevation: 0,
        side: isActive ? BorderSide.none : BorderSide(color: Colors.grey.shade200)
      ),
      child: Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
    );
  }
}
