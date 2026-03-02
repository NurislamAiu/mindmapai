import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';

import '../../domain/entities/usage_entry.dart';
import '../utils/date_formatter.dart';
import '../widgets/usage_empty_state.dart';
import '../widgets/usage_entry_card.dart';

class UsageHistoryScreen extends StatelessWidget {
  final List<UsageEntry> entries;
  final Function(UsageEntry)? onEntryClick;
  final VoidCallback? onAnalyzeNew;

  const UsageHistoryScreen({
    super.key,
    this.entries = const [],
    this.onEntryClick,
    this.onAnalyzeNew,
  });

  @override
  Widget build(BuildContext context) {
    final groupedEntries = DateFormatter.groupEntriesByDate(entries);
    final hasEntries = entries.isNotEmpty;

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
        top: false, // AppBar уже учитывает SafeArea сверху
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
                    "Usage History",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF111827),
                    ),
                  ),
                  const Gap(8),
                  const Text(
                    "Track how your AI credits were used.",
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

              // Content
              if (!hasEntries)
                UsageEmptyState(onAnalyzeNew: onAnalyzeNew)
              else
                ...groupedEntries.entries.toList().asMap().entries.map((groupPair) {
                  final groupIndex = groupPair.key;
                  final dateLabel = groupPair.value.key;
                  final dateEntries = groupPair.value.value;

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 32),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 4, bottom: 16),
                          child: Text(
                            dateLabel,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF374151),
                            ),
                          ),
                        ),
                        ...dateEntries.asMap().entries.map((entryPair) {
                          final entryIndex = entryPair.key;
                          final entry = entryPair.value;

                          return UsageEntryCard(
                            entry: entry,
                            onTap: onEntryClick != null
                                ? () => onEntryClick!(entry)
                                : null,
                          ).animate().fadeIn(
                                delay: ((groupIndex * 50) + (entryIndex * 30)).ms,
                                duration: 400.ms,
                              ).slideY(
                                begin: 0.1,
                                end: 0,
                                curve: Curves.easeOutQuint,
                              );
                        }),
                      ],
                    ).animate().fadeIn(
                          delay: (100 + (groupIndex * 50)).ms,
                          duration: 600.ms,
                        ).slideY(
                          begin: 0.1,
                          end: 0,
                          curve: Curves.easeOutQuint,
                        ),
                  );
                }),
            ],
          ),
        ),
      ),
    );
  }
}
