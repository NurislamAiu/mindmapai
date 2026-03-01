import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../domain/entities/mind_map_node_entity.dart';

class ChangesSummary extends StatelessWidget {
  final List<MindMapNodeEntity> added;
  final List<MindMapNodeEntity> modified;
  final List<MindMapNodeEntity> removed;

  const ChangesSummary({
    super.key,
    required this.added,
    required this.modified,
    required this.removed,
  });

  @override
  Widget build(BuildContext context) {
    bool noChanges = added.isEmpty && modified.isEmpty && removed.isEmpty;

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE9EBEF)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('What changed', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Color(0xFF030213))),
          const SizedBox(height: 16),
          if (noChanges)
            _buildChangeRow(
              icon: Iconsax.tick_circle,
              iconBgColor: const Color(0xFFF3F4F6),
              iconColor: const Color(0xFF4B5563),
              title: 'No structural changes between these versions',
            ),
          if (added.isNotEmpty)
            _buildChangeRow(
              icon: Iconsax.add,
              iconBgColor: const Color(0xFFECFDF5),
              iconColor: const Color(0xFF059669),
              title: 'Added ${added.length} new ${added.length == 1 ? "node" : "nodes"}',
              subtitle: added.map((n) => n.label).join(", "),
            ),
          if (modified.isNotEmpty)
            Padding(
              padding: EdgeInsets.only(top: added.isNotEmpty ? 16 : 0),
              child: _buildChangeRow(
                icon: Iconsax.edit,
                iconBgColor: const Color(0xFFFFFBEB),
                iconColor: const Color(0xFFB45309),
                title: 'Refined ${modified.length} ${modified.length == 1 ? "node" : "nodes"}',
                subtitle: modified.map((n) => n.label).join(", "),
              ),
            ),
          if (removed.isNotEmpty)
            Padding(
              padding: EdgeInsets.only(top: added.isNotEmpty || modified.isNotEmpty ? 16 : 0),
              child: _buildChangeRow(
                icon: Iconsax.minus,
                iconBgColor: const Color(0xFFFEF2F2),
                iconColor: const Color(0xFFB91C1C),
                title: 'Removed ${removed.length} ${removed.length == 1 ? "node" : "nodes"}',
                subtitle: removed.map((n) => n.label).join(", "),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildChangeRow({
    required IconData icon,
    required Color iconBgColor,
    required Color iconColor,
    required String title,
    String? subtitle,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: iconBgColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: iconColor, size: 16),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Color(0xFF030213))),
              if (subtitle != null) ...[
                const SizedBox(height: 2),
                Text(subtitle, style: const TextStyle(fontSize: 13, color: Color(0xFF717182))),
              ],
            ],
          ),
        ),
      ],
    );
  }
}
