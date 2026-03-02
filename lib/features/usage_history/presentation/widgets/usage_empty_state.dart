import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gap/gap.dart';
import 'package:iconsax/iconsax.dart';

class UsageEmptyState extends StatelessWidget {
  final VoidCallback? onAnalyzeNew;

  const UsageEmptyState({
    super.key,
    this.onAnalyzeNew,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 64),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFFEEF2FF), Color(0xFFF5F3FF)],
              ),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: const Color(0xFFE0E7FF)),
            ),
            child: const Icon(
              Iconsax.magic_star,
              size: 40,
              color: Color(0xFF4F46E5),
            ),
          ),
          const Gap(24),
          const Text(
            "You haven't used any AI credits yet",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: Color(0xFF111827),
            ),
          ),
          const Gap(8),
          const Text(
            "Your analyses will appear here.",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w300,
              color: Color(0xFF4B5563),
              height: 1.5,
            ),
          ),
          const Gap(32),
          ElevatedButton(
            onPressed: onAnalyzeNew,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF4F46E5),
              foregroundColor: Colors.white,
              elevation: 0,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Iconsax.add, size: 20),
                Gap(12),
                Text(
                  "Analyze a new idea",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.1, end: 0, curve: Curves.easeOutQuint);
  }
}
