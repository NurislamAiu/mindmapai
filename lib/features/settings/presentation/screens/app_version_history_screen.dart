import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';

import '../../domain/entities/app_version_log.dart';

class AppVersionHistoryScreen extends StatelessWidget {
  final List<AppVersionLog> versions;

  const AppVersionHistoryScreen({
    super.key,
    required this.versions,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F7F5),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: IconButton(
            onPressed: () => context.pop(),
            icon: const Icon(
              Iconsax.arrow_left_2,
              color: Color(0xFF111827),
              size: 24,
            ),
          ),
        ),
      ),
      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 8, 24, 96),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Release Notes",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF111827),
                    ),
                  ),
                  const Gap(8),
                  const Text(
                    "See what's new in the app.",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                      color: Color(0xFF4B5563),
                      height: 1.5,
                    ),
                  ),
                ],
              ).animate().fadeIn(duration: 600.ms).slideY(
                    begin: 0.1,
                    end: 0,
                    curve: Curves.easeOutQuint,
                  ),

              const Gap(32),

              // Content List
              ...versions.asMap().entries.map((entry) {
                final index = entry.key;
                final version = entry.value;

                return _buildVersionCard(version).animate().fadeIn(
                      delay: (100 + (index * 100)).ms,
                      duration: 600.ms,
                    ).slideY(
                      begin: 0.1,
                      end: 0,
                      curve: Curves.easeOutQuint,
                    );
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildVersionCard(AppVersionLog versionLog) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFF3F4F6)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x05000000),
            blurRadius: 10,
            offset: Offset(0, 4),
          )
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Version Header
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: const Color(0xFFEEF2FF),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    "v${versionLog.version}",
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF4338CA),
                    ),
                  ),
                ),
                const Spacer(),
                Text(
                  DateFormat('MMM d, yyyy').format(versionLog.releaseDate),
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF6B7280),
                  ),
                ),
              ],
            ),
            const Gap(24),

            // Features Section
            if (versionLog.newFeatures.isNotEmpty) ...[
              _buildSectionTitle(Iconsax.star1, "What's New", const Color(0xFFF59E0B)),
              const Gap(12),
              _buildBulletList(versionLog.newFeatures),
              const Gap(20),
            ],

            // Improvements Section
            if (versionLog.improvements.isNotEmpty) ...[
              _buildSectionTitle(Iconsax.flash_1, "Improvements", const Color(0xFF3B82F6)),
              const Gap(12),
              _buildBulletList(versionLog.improvements),
              const Gap(20),
            ],

            // Bug Fixes Section
            if (versionLog.bugFixes.isNotEmpty) ...[
              _buildSectionTitle(Iconsax.shield_tick, "Bug Fixes", const Color(0xFF10B981)),
              const Gap(12),
              _buildBulletList(versionLog.bugFixes),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(IconData icon, String title, Color color) {
    return Row(
      children: [
        Icon(icon, size: 18, color: color),
        const Gap(8),
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Color(0xFF111827),
          ),
        ),
      ],
    );
  }

  Widget _buildBulletList(List<String> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: items.map((item) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 6.0, right: 12.0),
                child: CircleAvatar(
                  radius: 3,
                  backgroundColor: Color(0xFFD1D5DB),
                ),
              ),
              Expanded(
                child: Text(
                  item,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w300,
                    color: Color(0xFF4B5563),
                    height: 1.5,
                  ),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
