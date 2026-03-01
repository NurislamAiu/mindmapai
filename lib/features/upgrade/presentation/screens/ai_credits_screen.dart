import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';

import '../widgets/ai_credits_action_section.dart';
import '../widgets/ai_credits_balance_card.dart';
import '../widgets/ai_credits_header.dart';
import '../widgets/ai_credits_history_link.dart';
import '../widgets/ai_credits_usage_explanation.dart';

class AICreditsScreen extends StatelessWidget {
  final int currentCredits;
  final VoidCallback? onGetCredits;
  final VoidCallback? onGoPro;
  final VoidCallback? onViewHistory;

  const AICreditsScreen({
    super.key,
    this.currentCredits = 3,
    this.onGetCredits,
    this.onGoPro,
    this.onViewHistory,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F7F5),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF8F7F5),
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: Icon(Iconsax.arrow_left_2, color: Colors.grey[900]),
          onPressed: () {
            if (context.canPop()) {
              context.pop();
            } else {
              context.go('/home');
            }
          },
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 8, 24, 96),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 672), // max-w-2xl
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Header text
                  const AICreditsHeader().animate().fade(duration: 600.ms).slideY(
                        begin: 0.2,
                        end: 0,
                        curve: const Cubic(0.22, 1, 0.36, 1),
                      ),
                  const Gap(32),

                  // Current balance card
                  AICreditsBalanceCard(currentCredits: currentCredits)
                      .animate(delay: 100.ms)
                      .fade(duration: 600.ms)
                      .slideY(
                        begin: 0.2,
                        end: 0,
                        curve: const Cubic(0.22, 1, 0.36, 1),
                      ),
                  const Gap(32),

                  // Usage explanation
                  const AICreditsUsageExplanation()
                      .animate(delay: 200.ms)
                      .fade(duration: 600.ms)
                      .slideY(
                        begin: 0.2,
                        end: 0,
                        curve: const Cubic(0.22, 1, 0.36, 1),
                      ),
                  const Gap(32),

                  // Action section
                  AICreditsActionSection(
                    onGetCredits: onGetCredits,
                    onGoPro: onGoPro,
                  ).animate(delay: 300.ms).fade(duration: 600.ms).slideY(
                        begin: 0.2,
                        end: 0,
                        curve: const Cubic(0.22, 1, 0.36, 1),
                      ),
                  const Gap(24),

                  // View history link
                  AICreditsHistoryLink(
                    onViewHistory: onViewHistory,
                  ).animate(delay: 400.ms).fade(duration: 600.ms).slideY(
                        begin: 0.2,
                        end: 0,
                        curve: const Cubic(0.22, 1, 0.36, 1),
                      ),
                  const Gap(32),

                  // Reassurance text
                  Text(
                    'You can track all credit usage in Usage History.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w300,
                      color: Colors.grey[500],
                      height: 1.5,
                    ),
                  ).animate(delay: 500.ms).fade(
                        duration: 600.ms,
                        curve: const Cubic(0.22, 1, 0.36, 1),
                      ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
