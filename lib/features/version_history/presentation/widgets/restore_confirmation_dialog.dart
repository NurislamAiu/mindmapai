import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:mindmapai/features/version_history/domain/entities/version_entity.dart';
import 'package:timeago/timeago.dart' as timeago;


Future<bool?> showRestoreConfirmationDialog(BuildContext context, VersionEntity version) {
  return showDialog<bool>(
    context: context,
    barrierColor: Colors.black.withOpacity(0.4),
    builder: (BuildContext context) {
      return Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.0)),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: const Color(0xFFEEF2FF),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Iconsax.rotate_left, color: Color(0xFF4F46E5), size: 20),
                  ),
                  const SizedBox(width: 16),
                  const Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(top: 4.0),
                      child: Text(
                        'Restore version?',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Color(0xFF030213)),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              RichText(
                text: TextSpan(
                  style: const TextStyle(fontSize: 15, color: Color(0xFF717182), height: 1.5, fontFamily: 'Manrope'),
                  children: <TextSpan>[
                    const TextSpan(text: 'You\'re about to restore '),
                    TextSpan(
                      text: version.label,
                      style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF030213)),
                    ),
                    TextSpan(text: ' from ${timeago.format(version.timestamp, locale: 'en_short')}.'),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'This will replace your current analysis. Your current version will be saved in history.',
                style: TextStyle(fontSize: 14, color: Color(0xFF717182), height: 1.5),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => context.pop(false),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        side: const BorderSide(color: Color(0xFFE9EBEF)),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      child: const Text('Cancel', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: Color(0xFF030213))),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => context.pop(true),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF4F46E5),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      child: const Text('Restore', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}
