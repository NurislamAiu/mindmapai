import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:mindmapai/features/compare/domain/entities/mind_map_version_entity.dart';

class VersionSelector extends StatelessWidget {
  final String label;
  final MindMapVersionEntity selectedVersion;
  final List<MindMapVersionEntity> allVersions;
  final Function(String) onVersionSelected;

  const VersionSelector({
    super.key,
    required this.label,
    required this.selectedVersion,
    required this.allVersions,
    required this.onVersionSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: Color(0xFF9A9AAA))),
        const SizedBox(height: 8),
        PopupMenuButton<String>(
          onSelected: onVersionSelected,
          offset: const Offset(0, 60),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
            side: const BorderSide(color: Color(0xFFE9EBEF)),
          ),
          color: Colors.white,
          elevation: 4,
          shadowColor: Colors.black.withOpacity(0.1),
          itemBuilder: (BuildContext context) {
            return allVersions.map((version) {
              final isSelected = version.id == selectedVersion.id;
              return PopupMenuItem<String>(
                value: version.id,
                child: Container(
                  width: double.infinity,
                  color: isSelected ? const Color(0xFFF4F5FF) : Colors.transparent,
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              version.label,
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                                color: isSelected ? const Color(0xFF4F46E5) : const Color(0xFF030213),
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              version.timestamp,
                              style: TextStyle(
                                fontSize: 13,
                                color: isSelected ? const Color(0xFF4F46E5) : const Color(0xFF717182),
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (isSelected)
                        const Icon(Iconsax.tick_circle, size: 20, color: Color(0xFF4F46E5)),
                    ],
                  ),
                ),
              );
            }).toList();
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: const Color(0xFFE9EBEF)),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(selectedVersion.label, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: Color(0xFF030213))),
                    const SizedBox(height: 2),
                    Text(selectedVersion.timestamp, style: const TextStyle(fontSize: 13, color: Color(0xFF717182))),
                  ],
                ),
                const Icon(Iconsax.arrow_down_1, size: 16, color: Color(0xFF717182)),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
