import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:iconsax/iconsax.dart';
import 'package:mindmapai/features/version_history/domain/entities/version_entity.dart';
import 'package:timeago/timeago.dart' as timeago;

class VersionCard extends StatelessWidget {
  final VersionEntity version;
  final bool isSelected;
  final bool isCurrent;
  final VoidCallback onTap;
  final VoidCallback onRestore;
  final VoidCallback onCompare;

  const VersionCard({
    super.key,
    required this.version,
    required this.isSelected,
    required this.isCurrent,
    required this.onTap,
    required this.onRestore,
    required this.onCompare,
  });

  @override
  Widget build(BuildContext context) {
    final changeTypeData = _getChangeTypeData(version.changeType);

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: onTap,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            padding: const EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              color: isSelected ? const Color(0xFFF8F9FF) : Colors.white,
              border: Border.all(color: isSelected ? const Color(0xFFC7D2FE) : const Color(0xFFE9EBEF)),
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(version.label, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w600, color: Color(0xFF030213))),
                    const SizedBox(width: 8),
                    if (isCurrent)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: const Color(0xFF4F46E5),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: const Text('CURRENT', style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w500)),
                      ),
                    const SizedBox(width: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: changeTypeData['bgColor'],
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(changeTypeData['text']!, style: TextStyle(color: changeTypeData['textColor'], fontSize: 11, fontWeight: FontWeight.w500)),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(version.description, style: const TextStyle(fontSize: 14, color: Color(0xFF717182), fontWeight: FontWeight.w400)),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Iconsax.clock, size: 14, color: Color(0xFF9A9AAA)),
                    const SizedBox(width: 6),
                    Text(
                      timeago.format(version.timestamp),
                      style: const TextStyle(fontSize: 13, color: Color(0xFF9A9AAA), fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        AnimatedSize(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          child: isSelected ? _buildExpandedContent(context) : const SizedBox(width: double.infinity),
        ),
      ],
    ).animate().fadeIn(duration: 400.ms, delay: 100.ms).slideY(begin: 0.1, duration: 400.ms);
  }

  Widget _buildExpandedContent(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 12),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE9EBEF)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Summary', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFF030213))),
          const SizedBox(height: 8),
          Text(version.summary, style: const TextStyle(fontSize: 14, color: Color(0xFF717182), height: 1.5)),
          const SizedBox(height: 20),
          _buildActionButtons(context),
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    if (isCurrent) {
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: const Color(0xFFECFDF5),
          border: Border.all(color: const Color(0xFFD1FAE5)),
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Iconsax.tick_circle, size: 16, color: Color(0xFF059669)),
            SizedBox(width: 8),
            Text('This is your current version', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Color(0xFF059669))),
          ],
        ),
      );
    }
    return Row(
      children: [
        Expanded(
          child: ElevatedButton.icon(
            onPressed: onRestore,
            icon: const Icon(Iconsax.rotate_left, size: 16),
            label: const Text('Restore'),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF4F46E5),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: OutlinedButton.icon(
            onPressed: onCompare,
            icon: const Icon(Iconsax.arrow_swap_horizontal, size: 16),
            label: const Text('Compare'),
            style: OutlinedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: const Color(0xFF030213),
              padding: const EdgeInsets.symmetric(vertical: 14),
              side: const BorderSide(color: Color(0xFFE9EBEF)),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
          ),
        ),
      ],
    );
  }
  
  Map<String, dynamic> _getChangeTypeData(ChangeType type) {
    switch (type) {
      case ChangeType.initial:
        return {'text': '✨ INITIAL', 'bgColor': const Color(0xFFF5F3FF), 'textColor': const Color(0xFF7C3AED)};
      case ChangeType.major:
        return {'text': '🚀 MAJOR', 'bgColor': const Color(0xFFEEF2FF), 'textColor': const Color(0xFF4338CA)};
      case ChangeType.refinement:
        return {'text': '🔍 REFINED', 'bgColor': const Color(0xFFECFDF5), 'textColor': const Color(0xFF047857)};
      default:
        return {'text': '📝 UPDATE', 'bgColor': const Color(0xFFF3F4F6), 'textColor': const Color(0xFF4B5563)};
    }
  }
}
